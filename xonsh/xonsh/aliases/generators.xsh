from random import SystemRandom
from string import ascii_lowercase, ascii_uppercase, digits
from xontrib.add_variable.decorators import alias

@alias
def pgen(args):
    N = int(args[0])
    print(''.join(
        SystemRandom()
            .choice(ascii_uppercase + digits + ascii_lowercase)
            for _ in range(N)
        )
    )
