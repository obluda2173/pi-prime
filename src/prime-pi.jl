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
    s = join(readlines("pi.txt"))
    # prefix = s[1:613373]
    prefix = s[3:61] # from 3 since I need to skip the 3 and . (julia for some reasin starts indexing from 1)
    prime = parse(BigInt, prefix)

    while (!isprime(prime))
        prime = prime ÷ 10
    end

    println(prime)
end

# second()


function third(filename, max_length=1000)
    str = read(filename, String)
    digits_str = str[3:end] # skip the "1."

    for len in min(max_length, length(digits_str)):-1:1
        substring = digits_str[1:len]

        if substring[end] in ('0', '2', '4', '5', '6', '8') # simple optimisation
            continue
        end

        num = parse(BigInt, substring)

        if isprime(num)
            println("Found prime prefix of length $len")
            println("Prime number: $(substring[1:len])")
            return num
        end

    end

    println("No prime prefix found")
    return nothing
end

third("pi.txt")
