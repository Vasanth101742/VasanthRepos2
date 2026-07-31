
# #1. Polynomial Function vs Rational Function Behaviour------------------------------

# import matplotlib.pyplot as plt
# import numpy as np

# # Create x-values
# x = np.linspace(-10, 10, 400)

# # Polynomial function
# poly = 0.1*x**3 - x**2 + 2*x + 3

# # Rational function: (x^2 - 1)/(x - 2)
# # Remove x=2 to avoid division error
# x_rational = x[x != 2]
# rational = (x_rational**2 - 1) / (x_rational - 2)

# # Plot both functions
# fig, axs = plt.subplots(1, 2, figsize=(12, 4))

# # Polynomial plot
# axs[0].plot(x, poly)
# axs[0].set_title("Polynomial Function: 0.1x³ - x² + 2x + 3")
# axs[0].axhline(0, color='black', linewidth=0.5)
# axs[0].axvline(0, color='black', linewidth=0.5)

# # Rational function plot
# axs[1].plot(x_rational, rational)
# axs[1].set_ylim(-20, 20)  # limit y-axis to show asymptote clearly
# axs[1].set_title("Rational Function: (x² - 1) / (x - 2)")
# axs[1].axhline(0, color='black', linewidth=0.5)
# axs[1].axvline(0, color='black', linewidth=0.5)
# axs[1].axvline(2, color='red', linestyle='--', label="Vertical asymptote at x=2")
# axs[1].legend()

# plt.tight_layout()
# plt.show()

#End  : 1. Polynomial Function vs Rational Function Behaviour--------------------------
#2. Closed Form Solution and Non Closed Form Solution----------------------------------

# import numpy as np
# import matplotlib.pyplot as plt

# x = np.linspace(-3, 3, 400)
# y = x**2 - 4

# plt.plot(x, y, label='y = x^2 - 4')
# plt.axhline(0, color='black', linewidth=0.5)
# plt.axvline(2, color='red', linestyle='--', label='x = 2')
# plt.axvline(-2, color='red', linestyle='--', label='x = -2')
# plt.title("Closed-Form Solution Example")
# plt.legend()
# plt.show()


# #-------------------

# import numpy as np
# import matplotlib.pyplot as plt
# from scipy.integrate import quad

# x = np.linspace(0, 1, 400)
# y = np.exp(-x**2)

# plt.plot(x, y, label='y = e^{-x^2}')
# plt.fill_between(x, 0, y, alpha=0.3, color='orange', label='Approximate integral area')
# plt.title("Non-Closed-Form Solution Example")
# plt.legend()
# plt.show()

# # Numerical integration
# integral_value, _ = quad(lambda x: np.exp(-x**2), 0, 1)
# print("Approximate integral:", integral_value)



#End : 2. Closed Form Solution and Non Closed Form Solution-----------------------------
#3. Noise is Gaussian  in Time Domain and White in Frequency Domain---------------------

import numpy as np
import matplotlib.pyplot as plt

# Generate White Gaussian Noise
wgn = np.random.normal(0, 1, 10000)


plt.figure(figsize=(10, 10))

# TIME DOMAIN: histogram (Gaussian)
plt.subplot(1, 2, 1)
plt.hist(wgn, bins=70, density=True)
plt.title("Time-Domain Distribution (Gaussian)")
#plt.show()

# FREQUENCY DOMAIN: power spectral density (white)
plt.subplot(1, 2, 2)
plt.psd(wgn, NFFT=1024)
plt.title("Frequency-Domain Spectrum (White)")
plt.show()

#End :3. Noise is Gaussian  in Time Domain and White in Frequency Domain-----------------