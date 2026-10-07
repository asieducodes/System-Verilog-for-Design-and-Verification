// module controller import pack_states::*;(
//     input  logic clk,
//                  rst,
//                  Amsb,
//                  count_gt_0,
//     output logic A_Rst,
//                  A_load,
//                  A_sel,
//                  Q_load,
//                  Q_sel,
//                  M_load,
//                  n_load,
//                  cnt_sel,
//                  alu_op,
//                  out_en
// );
// state_t ps, ns;

// // 1. Present State Register Block
// always_ff @(posedge clk, posedge rst) begin: ps_state_reg_blk
//     if (rst == 1'b1) 
//         ps <= S0;
//     else 
//         ps <= ns;
// end

// // 2. Next State Logic Block (Fixed for Look-Ahead Initialization)
// always_comb begin : ns_state_blk
//     case (ps) inside
//     S0: begin
//         if (rst == 1'b1)
//             ns = S0; // Hold look-ahead on S0 vector to ensure load signals assert during rst
//         else
//             ns = S1; // Transition to evaluation after rst is released
//     end
    
//     S1: begin 
//         if (Amsb == 1'b1)
//             ns = S2;
//         else
//             ns = S3;
//     end
    
//     S2, S3: ns = S6; // Unconditional transition to evaluation state
    
//     S6: begin
//         if (count_gt_0 == 1'b1) begin
//             ns = S1;
//         end else begin
//             if (Amsb == 1'b1)
//                 ns = S4;
//             else
//                 ns = S5;
//         end
//     end
    
//     S4: ns = S5; // Unconditional transition to output state
    
//     S5: ns = S5; // Remain in output state until system hard reset
    
//     default: ns = S0;
//     endcase
// end

// // 3. Output Logic Block (Look-Ahead Decoded via Next-State 'ns')
// always_comb begin: output_logic_blk
//     case (ns)
//     // S0: Initialize A=0, M=divisor, Q=dividend, count=n
//     S0:      {A_Rst, A_load, A_sel, Q_load, Q_sel, M_load, n_load, cnt_sel, alu_op, out_en} = 10'b1001011000;
    
//     // S1, S6: Wait and Evaluation States (all control registers hold steady)
//     S1, S6:  {A_Rst, A_load, A_sel, Q_load, Q_sel, M_load, n_load, cnt_sel, alu_op, out_en} = 10'b0000000000;
    
//     // S2: Shift AQ, A = A + M (alu_op=0), Decrement Counter (cnt_sel=1)
//     S2:      {A_Rst, A_load, A_sel, Q_load, Q_sel, M_load, n_load, cnt_sel, alu_op, out_en} = 10'b0101101100;
    
//     // S3: Shift AQ, A = A - M (alu_op=1), Decrement Counter (cnt_sel=1)
//     S3:      {A_Rst, A_load, A_sel, Q_load, Q_sel, M_load, n_load, cnt_sel, alu_op, out_en} = 10'b0101101110;
    
//     // S4: Final Restoration: A = A + M (A_sel=1 selects unshifted A)
//     S4:      {A_Rst, A_load, A_sel, Q_load, Q_sel, M_load, n_load, cnt_sel, alu_op, out_en} = 10'b0110000000;
    
//     // S5: Output Result (Enable Tristate Buffers)
//     S5:      {A_Rst, A_load, A_sel, Q_load, Q_sel, M_load, n_load, cnt_sel, alu_op, out_en} = 10'b0000000001;
    
//     default: {A_Rst, A_load, A_sel, Q_load, Q_sel, M_load, n_load, cnt_sel, alu_op, out_en} = 10'b1001011000;
//     endcase 
// end
// endmodule
module controller import pack_states::*; (
    input  logic clk,
    input  logic rst,

    // Status signals from datapath
    input  logic Amsb,
    input  logic count_gt_0,

    // Control signals to datapath
    output logic A_Rst,
    output logic A_load,
    output logic A_sel,

    output logic Q_load,
    output logic Q_sel,

    output logic M_load,

    output logic n_load,
    output logic cnt_sel,

    output logic alu_op,

    output logic out_en
);

    state_t ps, ns;


    // ========================================================
    // PRESENT STATE REGISTER
    // ========================================================

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            ps <= S0;
        else
            ps <= ns;
    end


    // ========================================================
    // NEXT STATE LOGIC
    // ========================================================

    always_comb begin

        ns = S0;

        case (ps)

            // ------------------------------------------------
            // Initialization
            // ------------------------------------------------
            S0: begin
                ns = S1;
            end


            // ------------------------------------------------
            // Check sign of A
            //
            // Amsb = 0 → A >= 0 → subtract M
            // Amsb = 1 → A < 0  → add M
            // ------------------------------------------------
            S1: begin
                if (Amsb)
                    ns = S2;
                else
                    ns = S3;
            end


            // ------------------------------------------------
            // Add operation
            // ------------------------------------------------
            S2: begin
                ns = S6;
            end


            // ------------------------------------------------
            // Subtract operation
            // ------------------------------------------------
            S3: begin
                ns = S6;
            end


            // ------------------------------------------------
            // Check counter
            // ------------------------------------------------
            S6: begin

                if (count_gt_0) begin
                    // More iterations required
                    ns = S1;
                end
                else begin

                    // Finished all iterations
                    if (Amsb)
                        ns = S4;
                    else
                        ns = S5;

                end

            end


            // ------------------------------------------------
            // Final restoration
            // A = A + M
            // ------------------------------------------------
            S4: begin
                ns = S5;
            end


            // ------------------------------------------------
            // Output
            // ------------------------------------------------
            S5: begin
                ns = S5;
            end


            default: begin
                ns = S0;
            end

        endcase

    end


    // ========================================================
    // OUTPUT / CONTROL SIGNAL DECODER
    // ========================================================

    always_comb begin

        // Default: hold everything
        A_Rst  = 1'b0;
        A_load = 1'b0;
        A_sel  = 1'b0;

        Q_load = 1'b0;
        Q_sel  = 1'b0;

        M_load = 1'b0;

        n_load = 1'b0;
        cnt_sel = 1'b0;

        alu_op = 1'b0;

        out_en = 1'b0;


        case (ps)

            // =================================================
            // S0: INITIALIZATION
            //
            // A     = 0
            // Q     = Dividend
            // M     = Divisor
            // count = 4
            // =================================================

            S0: begin

                A_Rst   = 1'b1;

                Q_load  = 1'b1;
                Q_sel   = 1'b0;       // Select dividend

                M_load  = 1'b1;

                n_load  = 1'b1;
                cnt_sel = 1'b0;       // Select 4

            end


            // =================================================
            // S1: CHECK SIGN OF A
            // =================================================

            S1: begin

                // Nothing changes in the datapath.
                // Controller only examines Amsb.

            end


            // =================================================
            // S2: SHIFT + ADD
            //
            // Previous A < 0
            //
            // A = shifted_A + M
            // Q = shifted_Q with new Q0
            // count = count - 1
            // =================================================

            S2: begin

                A_load  = 1'b1;
                A_sel   = 1'b0;       // Select shifted A

                Q_load  = 1'b1;
                Q_sel   = 1'b1;       // Select shifted Q

                n_load  = 1'b1;
                cnt_sel = 1'b1;       // Select count - 1

                alu_op  = 1'b0;       // ADD

            end


            // =================================================
            // S3: SHIFT + SUBTRACT
            //
            // Previous A >= 0
            //
            // A = shifted_A - M
            // Q = shifted_Q with new Q0
            // count = count - 1
            // =================================================

            S3: begin

                A_load  = 1'b1;
                A_sel   = 1'b0;       // Select shifted A

                Q_load  = 1'b1;
                Q_sel   = 1'b1;       // Select shifted Q

                n_load  = 1'b1;
                cnt_sel = 1'b1;       // Select count - 1

                alu_op  = 1'b1;       // SUBTRACT

            end


            // =================================================
            // S6: CHECK COUNTER
            // =================================================

            S6: begin

                // Hold all registers.
                // count_gt_0 determines the next state.

            end


            // =================================================
            // S4: FINAL RESTORATION
            //
            // If final A < 0:
            //
            // A = A + M
            //
            // IMPORTANT:
            // A_sel = 1 selects the unshifted A.
            // =================================================

            S4: begin

                A_load = 1'b1;

                A_sel  = 1'b1;        // Select current A

                alu_op = 1'b0;        // ADD M

            end


            // =================================================
            // S5: OUTPUT
            // =================================================

            S5: begin

                out_en = 1'b1;

            end


            default: begin

            end

        endcase

    end

endmodule