# using Pkg
# Pkg.add("Primes")
using Primes

# safe writer
function write_to_file(filename, s::AbstractString)
    open(filename, "w") do fd
        write(fd, s)
    end
end

const SMALL_PRIMES = (3,7,11,13,17,19,23,29,31,37,41,43,47,53,59,71,83,89,101,107,113,131,137)

"""
Search upward: start_len is the known length you have (e.g. 6205).
We will check start_len as well (if want to start strictly above, use start_len+1 when calling).
"""
function third_up(filename::AbstractString; start_len::Integer=6206, rounds::Integer=20, max_length::Integer=16210)
    s = read(filename, String)
    # handle a file that might start with "3." or "3"
    digits = startswith(s, "3.") ? s[3:end] : (startswith(s, "3") ? s[2:end] : s)
    total = min(max_length, lastindex(digits))
    if start_len < 1 || start_len > total
        throw(ArgumentError("start_len out of range: must be between 1 and $total"))
    end

    # parse initial prefix once
    prefix = digits[1:start_len]
    num = parse(BigInt, prefix)

    # precompute remainders mod small primes
    np = length(SMALL_PRIMES)
    rems = Vector{Int}(undef, np)
    for i in 1:np
        rems[i] = Int(mod(num, SMALL_PRIMES[i]))
    end

    # Optionally test the start_len first
    for len in start_len:total
        if len != start_len
            # extend by one digit
            ch = digits[len]                      # Char
            d = Int(ch) - Int('0')               # digit 0..9
            # update BigInt
            num = num * 10 + BigInt(d)
            # update remainders
            @inbounds for i in 1:np
                p = SMALL_PRIMES[i]
                rems[i] = Int((rems[i] * 10 + d) % p)
            end
        end

        # print progress occasionally
        if len % 1000 == 0 || len == start_len
            println("checking length = $len")
        end

        # last-digit quick filter (skip even or 5)
        lastd = Int(digits[len]) - Int('0')
        if lastd in (0,2,4,5,6,8)
            continue
        end

        # small-prime sieve
        is_div_by_small = false
        @inbounds for r in rems
            if r == 0
                is_div_by_small = true
                break
            end
        end
        if is_div_by_small
            continue
        end

        # probable-prime test (cheap filter)
        if isprime(num, rounds)
            outfn = "../primes/prime-$(len).txt"
            accuracy = 1 - 4.0^(-rounds)
            println("Found prime of length: $len")
            println("Probable-prime accuracy: $accuracy")
            write_to_file(outfn, digits[1:len])
            println("Saved to $outfn")
            return num
        end
    end

    println("No prime found up to length $total")
    return nothing
end

# example call: start at 6205 and scan upward
third_up("../pi.txt"; start_len=16351, rounds=1, max_length=1000000000)
