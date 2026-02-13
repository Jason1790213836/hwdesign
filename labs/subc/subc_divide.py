import numpy as np
import matplotlib.pyplot as plt

def subc_divide(
        a : np.uint32,
        b : np.uint32,
        nbits : int = 16
    ) -> np.int32:
    
    if b == 0:
        raise ValueError("Division by zero is not allowed.")
    if (a >= b) or (a < 0):
        raise ValueError("We must have a < b and a >= 0.")

    # Initialize z and the remainder (remainder starts as 'a')
    z = 0
    rem = a

    # We iterate for the number of fractional bits required
    for _ in range(nbits):
        # Shift the remainder left (multiply by 2)
        rem <<= 1
        # Shift z left to make room for the next bit
        z <<= 1
        
        # Conditional Subtraction:
        # If the divisor 'b' fits into the current remainder...
        if rem >= b:
            rem -= b   # Subtract the divisor
            z += 1     # Set the current bit of the quotient to 1

    return z