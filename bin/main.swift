import Foundation

extension Array {
    func markPrimes() -> [Int] {
        var result = Array<Int>()
        for index in 0...self.count {
            let map1 = self.mapPrime(index);
            if map1 == 1 {
                result.append(index)
            }
        }
        return result
    }
    // we know 2,3,5,7 are prime
    func isPrime(_ n:Int, _ prime:inout [Int], _ id:Int, _ result:Int)  -> Int {
        switch n {
        case let x where x >= 4:
            return result;
        default:
            let r = result | (id == prime[n] ? 1 : 0);
            return isPrime(n+1, &prime, id, r);
        }
    }

    // find numbers who are factors
    func isPrimeFactor(_ n:Int, _ prime:inout [Int], _ id:Int, _ result:Int) -> Int {
        switch n {
        case let x where x >= 4:
            return result
        default:
            let r = result & (id % prime[n] != 0 ? 1 : 0);
            return isPrimeFactor(n+1, &prime, id, r);
        }
    }
    func mapPrime(_ id:Int) -> Int {
        switch id {
        case let x where x<2:
            return 0;
        default:
            var result = 1
            var prime:[Int] = [2,3,5,7];
            let i = isPrime(0, &prime, id, 0)
            switch i {
            case let y where y == 1:
                return result
            default:
                // bound is square root of "high"
                let a:Double = Double(id)
                let b:Double = sqrt(a)
                let r = isPrimeFactor(0, &prime, id, 1);
                return r & (b - floor(b) != 0 ? 1 : 0);
            }
        }
    }
}

// Driver Program to test above function
func main()
{
    let input = 10;
    print("[INPUT] \(input)");
    let output = Array<Int>(repeating:0, count:input).markPrimes()
    print("[OUTPUT] \(output)");
}
main();
