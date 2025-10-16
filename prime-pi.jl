# using Pkg
# Pkg.add("Primes")

using Primes

function first()
    prime = BigInt(141592653589793238462643383279502884197)

    while (!isprime(prime))
        prime = prime ÷ 10
    end

    println(prime)
end

# first()

# apperantly BigInt in julia is limited by ram only
function second()
    s = join(readlines("pi.txt"))
    prefix = s[1:613373]
    prime = parse(BigInt, prefix)

    while (!isprime(prime))
        prime = prime ÷ 10
    end

    println(prime)
end

second()
