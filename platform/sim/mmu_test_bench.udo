onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider In
add wave -noupdate -label r /mmu_test_bench/r_stb
add wave -noupdate -label w /mmu_test_bench/w_stb
add wave -noupdate -label s /mmu_test_bench/priv_stb
add wave -noupdate -label real /mmu_test_bench/real_mode
add wave -noupdate -label pt_base -radix hexadecimal /mmu_test_bench/pt_base_in
add wave -noupdate -color Magenta -label VA_in -radix hexadecimal /mmu_test_bench/v_addr_in
add wave -noupdate -divider {MMU out}
add wave -noupdate -color {Slate Blue} -label p_addr -radix hexadecimal /mmu_test_bench/p_addr_o
add wave -noupdate -label flags /mmu_test_bench/flags_o
add wave -noupdate -label busy /mmu_test_bench/busy_o
add wave -noupdate -label p_fault /mmu_test_bench/p_fault_o
add wave -noupdate -divider {RAM transact.}
add wave -noupdate -label addr -radix hexadecimal /mmu_test_bench/ram_addr_o
add wave -noupdate -label data_o -radix hexadecimal /mmu_test_bench/ram_data_in
add wave -noupdate -label data_in -radix hexadecimal /mmu_test_bench/ram_data_o
add wave -noupdate -label we /mmu_test_bench/ram_we_o
add wave -noupdate -divider {RAM Debug}
add wave -noupdate -label debug -radix hexadecimal /mmu_test_bench/doutb
add wave -noupdate -divider {Test Phase}
add wave -noupdate -label phase /mmu_test_bench/phase
add wave -noupdate -label clk /mmu_test_bench/uut/tlb/record_bank/clk
add wave -noupdate -divider PTW
add wave -noupdate -label va_in -radix hexadecimal /mmu_test_bench/uut/ptw/v_addr_in
add wave -noupdate -label sr_out -radix hexadecimal /mmu_test_bench/uut/ptw/shift_reg/data_out
add wave -noupdate -label shift_Reg -radix hexadecimal -subitemconfig {/mmu_test_bench/uut/ptw/shift_reg/shift_reg(0) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(0)(25) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(0)(24) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(0)(23) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(0)(22) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(0)(21) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(0)(20) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(0)(19) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(0)(18) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(0)(17) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(0)(16) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(0)(15) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(0)(14) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(0)(13) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(0)(12) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(0)(11) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(0)(10) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(0)(9) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(0)(8) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(0)(7) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(0)(6) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(0)(5) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(0)(4) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(0)(3) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(0)(2) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(0)(1) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(0)(0) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(1) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(2) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(3) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(4) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(5) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(6) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(7) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(8) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/ptw/shift_reg/shift_reg(9) {-height 15 -radix hexadecimal}} /mmu_test_bench/uut/ptw/shift_reg/shift_reg
add wave -noupdate -label tlb_miss_i /mmu_test_bench/uut/ptw/tlb_miss_in
add wave -noupdate -label tlb_evict_in /mmu_test_bench/uut/ptw/tlb_evict_in
add wave -noupdate -label tlb_flags_in /mmu_test_bench/uut/ptw/tlb_flags_in
add wave -noupdate -label pte_temp -radix hexadecimal /mmu_test_bench/uut/ptw/pte_tmp
add wave -noupdate -label state /mmu_test_bench/uut/ptw/state
add wave -noupdate -label word /mmu_test_bench/uut/ptw/word
add wave -noupdate -label tlb_wb /mmu_test_bench/uut/ptw/tlb_wb_stb
add wave -noupdate -label pte_o -radix hexadecimal /mmu_test_bench/uut/ptw/pte_o
add wave -noupdate -label rws_flags /mmu_test_bench/uut/ptw/rws_flags
add wave -noupdate -divider TEC/internal
add wave -noupdate -label tec_index_o -radix unsigned /mmu_test_bench/uut/tec/index_o
add wave -noupdate -divider TLB
add wave -noupdate -radix hexadecimal /mmu_test_bench/uut/tlb_evicted_va
add wave -noupdate -label we /mmu_test_bench/uut/tlb/we
add wave -noupdate -label v_addr -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/v_addr_in
add wave -noupdate -label data_o -radix hexadecimal /mmu_test_bench/uut/tlb_data
add wave -noupdate -label data_i -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/data_i
add wave -noupdate -label w_select -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/w_select
add wave -noupdate -group tlb_contents -label reg_0 -radix hexadecimal -expand -subitemconfig {/mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(37) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(36) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(35) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(34) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(33) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(32) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(31) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(30) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(29) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(28) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(27) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(26) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(25) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(24) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(23) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(22) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(21) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(20) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(19) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(18) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(17) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(16) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(15) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(14) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(13) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(12) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(11) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(10) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(9) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(8) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(7) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(6) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(5) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(4) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(3) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(2) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(1) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q(0) {-height 15 -radix hexadecimal}} /mmu_test_bench/uut/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_1 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(1)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_2 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(2)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_3 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(3)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_4 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(4)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_5 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(5)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_6 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(6)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_7 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(7)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_8 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(8)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_9 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(9)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_10 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(10)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_11 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(11)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_12 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(12)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_13 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(13)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_14 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(14)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_15 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(15)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_16 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(16)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_17 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(17)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_18 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(18)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_19 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(19)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_20 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(20)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_21 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(21)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_22 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(22)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_23 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(23)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_24 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(24)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_25 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(25)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_26 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(26)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_27 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(27)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_28 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(28)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_29 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(29)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_30 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(30)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_31 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(31)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_32 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(32)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_33 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(33)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_34 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(34)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_35 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(35)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_36 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(36)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_37 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(37)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_38 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(38)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_39 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(39)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_40 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(40)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_41 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(41)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_42 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(42)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_43 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(43)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_44 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(44)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_45 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(45)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_46 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(46)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_47 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(47)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_48 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(48)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_49 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(49)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_50 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(50)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_51 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(51)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_52 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(52)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_53 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(53)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_54 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(54)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_55 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(55)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_56 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(56)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_57 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(57)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_58 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(58)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_59 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(59)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_60 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(60)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_61 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(61)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_62 -radix hexadecimal /mmu_test_bench/uut/tlb/record_bank/tlb_block(62)/tlb/tlb_reg/q
add wave -noupdate -group tlb_contents -label reg_63 -radix hexadecimal -expand -subitemconfig {/mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(37) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(36) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(35) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(34) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(33) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(32) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(31) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(30) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(29) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(28) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(27) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(26) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(25) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(24) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(23) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(22) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(21) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(20) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(19) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(18) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(17) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(16) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(15) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(14) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(13) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(12) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(11) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(10) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(9) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(8) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(7) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(6) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(5) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(4) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(3) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(2) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(1) {-height 15 -radix hexadecimal} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q(0) {-height 15 -radix hexadecimal}} /mmu_test_bench/uut/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {178796 ps} 0}
configure wave -namecolwidth 102
configure wave -valuecolwidth 117
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {100506 ps} {387678 ps}
