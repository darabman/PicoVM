onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label reset_i /picoblaze_tb/clk_i
add wave -noupdate -label clock_i /picoblaze_tb/rst_i
add wave -noupdate -expand -group RAM -label {CPU we} -radix hexadecimal /picoblaze_tb/uut/ram/wea
add wave -noupdate -expand -group RAM -label {CPU addr} -radix hexadecimal /picoblaze_tb/uut/ram/addra
add wave -noupdate -expand -group RAM -label {CPU data_in} -radix hexadecimal /picoblaze_tb/uut/ram/dina
add wave -noupdate -expand -group RAM -label {CPU data_out} -radix hexadecimal /picoblaze_tb/uut/ram/douta
add wave -noupdate -expand -group RAM -label {MMU we} -radix hexadecimal /picoblaze_tb/uut/ram/web
add wave -noupdate -expand -group RAM -label {MMU addr} -radix hexadecimal /picoblaze_tb/uut/ram/addrb
add wave -noupdate -expand -group RAM -label {MMU data_in} -radix hexadecimal /picoblaze_tb/uut/ram/dinb
add wave -noupdate -expand -group RAM -label {MMU data_out} -radix hexadecimal /picoblaze_tb/uut/ram/doutb
add wave -noupdate -group MMU -divider In
add wave -noupdate -group MMU -label r /picoblaze_tb/uut/CPU/mmu/r_stb
add wave -noupdate -group MMU -label w /picoblaze_tb/uut/CPU/mmu/w_stb
add wave -noupdate -group MMU -label s /picoblaze_tb/uut/CPU/mmu/priv_stb
add wave -noupdate -group MMU -label real /picoblaze_tb/uut/CPU/mmu/real_mode
add wave -noupdate -group MMU -label pt_base -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/pt_base_in
add wave -noupdate -group MMU -color Magenta -label VA_in -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/v_addr_in
add wave -noupdate -group MMU -divider {MMU out}
add wave -noupdate -group MMU -color {Slate Blue} -label p_addr -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/p_addr_o
add wave -noupdate -group MMU -label flags /picoblaze_tb/uut/CPU/mmu/flags_o
add wave -noupdate -group MMU -label busy /picoblaze_tb/uut/CPU/mmu/busy_o
add wave -noupdate -group MMU -label p_fault /picoblaze_tb/uut/CPU/mmu/p_fault_o
add wave -noupdate -group MMU -divider PTW
add wave -noupdate -group MMU -label va_in -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/ptw/v_addr_in
add wave -noupdate -group MMU -label sr_out -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/ptw/shift_reg/data_out
add wave -noupdate -group MMU -label shift_Reg -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/ptw/shift_reg/shift_reg
add wave -noupdate -group MMU -label tlb_miss_i /picoblaze_tb/uut/CPU/mmu/ptw/tlb_miss_in
add wave -noupdate -group MMU -label tlb_evict_in /picoblaze_tb/uut/CPU/mmu/ptw/tlb_evict_in
add wave -noupdate -group MMU -label tlb_flags_in /picoblaze_tb/uut/CPU/mmu/ptw/tlb_flags_in
add wave -noupdate -group MMU -label pte_temp -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/ptw/pte_tmp
add wave -noupdate -group MMU -label state /picoblaze_tb/uut/CPU/mmu/ptw/state
add wave -noupdate -group MMU -label word /picoblaze_tb/uut/CPU/mmu/ptw/word
add wave -noupdate -group MMU -label tlb_wb /picoblaze_tb/uut/CPU/mmu/ptw/tlb_wb_stb
add wave -noupdate -group MMU -label pte_o -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/ptw/pte_o
add wave -noupdate -group MMU -label rws_flags /picoblaze_tb/uut/CPU/mmu/ptw/rws_flags
add wave -noupdate -group MMU -divider TEC/internal
add wave -noupdate -group MMU -label tec_index_o -radix unsigned /picoblaze_tb/uut/CPU/mmu/tec/index_o
add wave -noupdate -group MMU -divider TLB
add wave -noupdate -group MMU -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb_evicted_va
add wave -noupdate -group MMU -label we /picoblaze_tb/uut/CPU/mmu/tlb/we
add wave -noupdate -group MMU -label v_addr -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/v_addr_in
add wave -noupdate -group MMU -label data_o -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb_data
add wave -noupdate -group MMU -label data_i -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/data_i
add wave -noupdate -group MMU -label w_select -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/w_select
add wave -noupdate -group MMU -group tlb_contents -label reg_0 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(0)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_1 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(1)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_2 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(2)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_3 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(3)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_4 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(4)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_5 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(5)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_6 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(6)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_7 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(7)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_8 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(8)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_9 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(9)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_10 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(10)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_11 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(11)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_12 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(12)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_13 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(13)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_14 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(14)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_15 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(15)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_16 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(16)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_17 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(17)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_18 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(18)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_19 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(19)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_20 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(20)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_21 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(21)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_22 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(22)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_23 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(23)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_24 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(24)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_25 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(25)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_26 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(26)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_27 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(27)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_28 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(28)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_29 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(29)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_30 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(30)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_31 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(31)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_32 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(32)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_33 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(33)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_34 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(34)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_35 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(35)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_36 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(36)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_37 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(37)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_38 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(38)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_39 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(39)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_40 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(40)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_41 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(41)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_42 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(42)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_43 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(43)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_44 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(44)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_45 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(45)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_46 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(46)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_47 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(47)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_48 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(48)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_49 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(49)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_50 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(50)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_51 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(51)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_52 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(52)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_53 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(53)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_54 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(54)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_55 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(55)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_56 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(56)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_57 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(57)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_58 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(58)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_59 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(59)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_60 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(60)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_61 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(61)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_62 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(62)/tlb/tlb_reg/q
add wave -noupdate -group MMU -group tlb_contents -label reg_63 -radix hexadecimal /picoblaze_tb/uut/CPU/mmu/tlb/record_bank/tlb_block(63)/tlb/tlb_reg/q
add wave -noupdate -expand -group CPU -label offset -radix hexadecimal /picoblaze_tb/uut/CPU/core_cpu/d_adr_o
add wave -noupdate -expand -group CPU -label data_i -radix hexadecimal /picoblaze_tb/uut/CPU/core_cpu/d_dat_i
add wave -noupdate -expand -group CPU -label data_o -radix hexadecimal /picoblaze_tb/uut/CPU/core_cpu/d_dat_o
add wave -noupdate -expand -group CPU -label inst_Addr -radix hexadecimal /picoblaze_tb/uut/CPU/core_cpu/i_adr_o
add wave -noupdate -expand -group CPU -label inst -radix hexadecimal /picoblaze_tb/uut/CPU/core_cpu/i_dat_i
add wave -noupdate -expand -group CPU -label mmu_int -radix hexadecimal /picoblaze_tb/uut/CPU/core_cpu/int_i
add wave -noupdate -expand -group CPU -label int_ack -radix hexadecimal /picoblaze_tb/uut/CPU/core_cpu/int_ack_o
add wave -noupdate -divider clocks
add wave -noupdate -label istr /picoblaze_tb/uut/CPU/istr_clk
add wave -noupdate -label cpu /picoblaze_tb/uut/CPU/cpu_clk
add wave -noupdate -divider Imem
add wave -noupdate -radix hexadecimal /picoblaze_tb/uut/CPU/rom/port_a_adr_i
add wave -noupdate -radix hexadecimal /picoblaze_tb/uut/CPU/rom/port_a_dat_o
add wave -noupdate -divider Amem
add wave -noupdate -radix hexadecimal /picoblaze_tb/uut/CPU/rom_extended/addr
add wave -noupdate -radix hexadecimal /picoblaze_tb/uut/CPU/rom_extended/data_in
add wave -noupdate -radix hexadecimal /picoblaze_tb/uut/CPU/rom_extended/data_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {13506 ps} 0}
configure wave -namecolwidth 302
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {310195 ps}
eval [exec {C:/temp/pbug.exe} modelsim]
