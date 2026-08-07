# Copy this complete directory into
# heichips26-tapeout/user_designs/designs/classic/ before building.
RTL = loopcache_sram_gateway.sv
TOP = loopcache_sram_gateway

test-core: ## Test the packet engine without the full FABulous fabric
	iverilog -g2012 -DLOOPCACHE_GATEWAY_CORE_ONLY \
		-s loopcache_sram_gateway_tb -o test_gateway_core \
		$(RTL) loopcache_sram_gateway_tb.sv
	vvp test_gateway_core
	rm -f test_gateway_core
.PHONY: test-core

-include ../../../makefile.include
