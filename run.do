vlib work
vlog spi.v ram.v Wrapper.v Wrapper_tb.v
vsim -voptargs=+acc work.Wrapper_tb
add wave *
add wave -position insertpoint  \
sim:/Wrapper_tb/DUT3/DUT2/mem
add wave -position insertpoint  \
sim:/Wrapper_tb/DUT3/DUT2/din
add wave -position insertpoint  \
sim:/Wrapper_tb/DUT3/DUT1/rx_data \
sim:/Wrapper_tb/DUT3/DUT1/rx_valid \
sim:/Wrapper_tb/DUT3/DUT1/tx_valid \
sim:/Wrapper_tb/DUT3/DUT1/tx_data
add wave -position insertpoint  \
sim:/Wrapper_tb/DUT3/DUT2/addr
add wave -position insertpoint  \
sim:/Wrapper_tb/DUT3/DUT2/dout
run -all