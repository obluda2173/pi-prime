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


function second()
    s = join(readlines("pi.txt"))
    prefix = s[3:61] # from 3 since I need to skip the 3 and . (julia for some reasin starts indexing from 1)
    prime = parse(BigInt, prefix)

    while (!isprime(prime))
        prime = prime ÷ 10
    end

    println(prime)
end

# second()


function write_to_file(filename, prime)
    fd = open(filename, "w")
    write(fd, prime)
    close(fd)
end

function is_divisible_by_small_primes(num)
    small_primes = [3, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47]
    for prime in small_primes
        if num % prime == 0 && num != prime
            return true
        end
    end
    return false
end

function third(filename, rounds=20, max_length=1000000000)
    str = read(filename, String)
    digits_str = str[3:end] # skip the "1."

    for len in 63500:1:length(digits_str)
        substring = digits_str[1:len]

        if len % 100 == 0
            println(len)
        end

        if substring[end] in ['0', '2', '4', '5', '6', '8'] # simple optimisation
            continue
        end

        num = parse(BigInt, substring)

        if is_divisible_by_small_primes(num)
            continue
        end

        if isprime(num, rounds)
            prime_filename = "./primes/prime-$(len).txt"
            accuracy = 1 - 4^float(-rounds)
            println("Found prime has length of: $len")
            println("Accuracy of the found number being prime is: $accuracy")
            write_to_file(prime_filename, substring[1:len])
            println("Prime number has been stored into $prime_filename")
            # return num
        end

    end

    println("No prime prefix found")
    # return nothing
end

third("pi.txt", 2)
