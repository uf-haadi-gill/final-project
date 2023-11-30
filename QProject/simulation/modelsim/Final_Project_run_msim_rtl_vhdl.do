transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/quinc/Documents/UF_FALL_2023/EEL4712C-Digital_Design/final project/Register File/register_file.vhd}
vcom -93 -work work {C:/Users/quinc/Documents/UF_FALL_2023/EEL4712C-Digital_Design/final project/Instruction Register/instruction_register.vhd}
vcom -93 -work work {C:/Users/quinc/Documents/UF_FALL_2023/EEL4712C-Digital_Design/final project/Generic Components/zero_extend.vhd}
vcom -93 -work work {C:/Users/quinc/Documents/UF_FALL_2023/EEL4712C-Digital_Design/final project/Generic Components/sign_extend.vhd}
vcom -93 -work work {C:/Users/quinc/Documents/UF_FALL_2023/EEL4712C-Digital_Design/final project/Generic Components/shift_left_2.vhd}
vcom -93 -work work {C:/Users/quinc/Documents/UF_FALL_2023/EEL4712C-Digital_Design/final project/Generic Components/reg.vhd}
vcom -93 -work work {C:/Users/quinc/Documents/UF_FALL_2023/EEL4712C-Digital_Design/final project/Generic Components/mux4to1.vhd}
vcom -93 -work work {C:/Users/quinc/Documents/UF_FALL_2023/EEL4712C-Digital_Design/final project/Generic Components/mux3to1.vhd}
vcom -93 -work work {C:/Users/quinc/Documents/UF_FALL_2023/EEL4712C-Digital_Design/final project/Generic Components/mux2to1.vhd}
vcom -93 -work work {C:/Users/quinc/Documents/UF_FALL_2023/EEL4712C-Digital_Design/final project/Generic Components/concat.vhd}
vcom -93 -work work {C:/Users/quinc/Documents/UF_FALL_2023/EEL4712C-Digital_Design/final project/Controller/controller.vhd}
vcom -93 -work work {C:/Users/quinc/Documents/UF_FALL_2023/EEL4712C-Digital_Design/final project/ALU_Control/ALU_Control.vhd}
vcom -93 -work work {C:/Users/quinc/Documents/UF_FALL_2023/EEL4712C-Digital_Design/final project/ALU/ALU_Main.vhd}
vcom -93 -work work {C:/Users/quinc/Documents/UF_FALL_2023/EEL4712C-Digital_Design/final project/QProject/RAM.vhd}
vcom -93 -work work {C:/Users/quinc/Documents/UF_FALL_2023/EEL4712C-Digital_Design/final project/Memory/Memory.vhd}
vcom -93 -work work {C:/Users/quinc/Documents/UF_FALL_2023/EEL4712C-Digital_Design/final project/Datapath/Datapath.vhd}
vcom -93 -work work {C:/Users/quinc/Documents/UF_FALL_2023/EEL4712C-Digital_Design/final project/TopLevel/topLevel.vhd}

