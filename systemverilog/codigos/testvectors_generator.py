import functools
import operator

NUM_TESTCASES = 100

class Register:
    def __init__(self, value, width):
        self.value, self.width = value, width

    def __getitem__(self, position):
        return (self.value >> position) & 1

    def __str__(self):
        return bin(self.value)[2:].zfill(self.width)

class LFSR:
    WIDTH = 32
    TAPS  = 0, 1, 21, 31

    def __init__(self, seed = 1):
        self.register = Register(seed, width = self.WIDTH)

    def get_output(self):
        # Calcula o feedback usando XOR nos bits especificados pelos TAPS
        feedback = functools.reduce(operator.xor, [self.register[tap] for tap in self.TAPS])

        # Desloca o registrador para a direita e insere o feedback no bit mais significativo
        self.register.value = (self.register.value >> 1) | (feedback << (self.WIDTH - 1))
        return str(self.register)

def main():
    lfsr = LFSR()
    testvectors = [lfsr.get_output() for _ in range(NUM_TESTCASES)]
    with open('testvectors.txt', 'w') as file:
        file.write('\n'.join(testvectors))

if __name__ == '__main__':
    main()
