JULIA=julia
SRC=src/prime-pi.jl

.PHONY: run clean

run:
	$(JULIA) $(SRC)

clean:
	@echo "Nothing to clean for now"
