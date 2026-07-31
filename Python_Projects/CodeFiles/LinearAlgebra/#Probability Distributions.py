#Probability Distributions

import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import bernoulli, norm

# ----------------------------------------
# Discrete distribution: Bernoulli(p=0.6)
# ----------------------------------------
p = 0.6
x_discrete = [0, 1]
pmf_vals = bernoulli.pmf(x_discrete, p)
cdf_vals_discrete = bernoulli.cdf(x_discrete, p)

# ----------------------------------------
# Continuous distribution: Normal(mean=0, sd=1)
# ----------------------------------------
x_continuous = np.linspace(-4, 4, 400)
pdf_vals = norm.pdf(x_continuous, 0, 1)
cdf_vals_continuous = norm.cdf(x_continuous, 0, 1)

# ----------------------------------------
# Plotting
# ----------------------------------------
plt.figure(figsize=(14, 10))

# PMF (Discrete)
plt.subplot(2, 2, 1)
plt.stem(x_discrete, pmf_vals, use_line_collection=True)
plt.title("PMF (Bernoulli p=0.6)")
plt.xlabel("x")
plt.ylabel("P(X = x)")
plt.ylim(0, 1)

# PDF (Continuous)
plt.subplot(2, 2, 2)
plt.plot(x_continuous, pdf_vals, 'b')
plt.title("PDF (Normal μ=0, σ=1)")
plt.xlabel("x")
plt.ylabel("Density")
plt.grid(True)

# CDF (Discrete)
plt.subplot(2, 2, 3)
plt.step(x_discrete, cdf_vals_discrete, where='post')
plt.title("CDF (Bernoulli p=0.6)")
plt.xlabel("x")
plt.ylabel("P(X ≤ x)")
plt.ylim(0, 1.1)
plt.grid(True)

# CDF (Continuous)
plt.subplot(2, 2, 4)
plt.plot(x_continuous, cdf_vals_continuous, 'g')
plt.title("CDF (Normal μ=0, σ=1)")
plt.xlabel("x")
plt.ylabel("P(X ≤ x)")
plt.grid(True)

plt.tight_layout()
plt.show()






#-------------------------------------------------------------------

# #Beta Distribution

# import numpy as np
# import matplotlib.pyplot as plt
# from scipy.stats import beta

# # x-axis values between 0 and 1
# x = np.linspace(0, 1, 500)

# # Different shape parameters (alpha, beta)
# params = [
#     (0.5, 0.5),
#     (2, 2),
#     (2, 5),
#     (5, 2),
#     (5, 5),
# ]

# plt.figure(figsize=(10, 6))

# for a, b in params:
#     y = beta.pdf(x, a, b)
#     plt.plot(x, y, label=f"a={a}, b={b}")

# plt.title("Beta Distribution for Different α and β")
# plt.xlabel("x")
# plt.ylabel("PDF")
# plt.legend()
# plt.grid(True)
# plt.show()
