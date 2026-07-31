#Conjugate Roots visualization
import matplotlib.pyplot as plt

# Roots
x1 = complex(-0.5, 3**0.5/2)
x2 = complex(-0.5, -3**0.5/2)

# Plotting
plt.figure(figsize=(6,6))
plt.axhline(0, color='black', linewidth=1)  # Real axis
plt.axvline(0, color='black', linewidth=1)  # Imaginary axis
plt.scatter([x1.real, x2.real], [x1.imag, x2.imag], color='red', s=100)
plt.text(x1.real+0.05, x1.imag, 'x1', fontsize=12)
plt.text(x2.real+0.05, x2.imag, 'x2', fontsize=12)
plt.title('Conjugate Roots on the Complex Plane')
plt.xlabel('Real')
plt.ylabel('Imaginary')
plt.grid(True)
plt.show()
