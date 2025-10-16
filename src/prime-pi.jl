# using Pkg
# Pkg.add("Primes")

using Primes

# super simple first approach
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
    # s = join(readlines("../pi.txt"))
    s = join(readlines("pi.txt"))
    # prefix = s[1:613373]
    prefix = s[3:61] # from 3 since I need to skip the 3 and . (julia for some reasin starts indexing from 1)
    prime = parse(BigInt, prefix)

    while (!isprime(prime))
        prime = prime ÷ 10
    end

    println(prime)
end

second()
