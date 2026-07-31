
# Derivative Based Algorithms
# # 1.Batch Gradient Descent Algorithm (BGD)
# import numpy as np
# import matplotlib.pyplot as plt

# # Sample data (linear with some noise)
# np.random.seed(42)
# X = 2 * np.random.rand(100)
# y = 4 + 3 * X + np.random.randn(100)

# # Parameters initialization
# w = 0.0
# b = 0.0
# learning_rate = 0.1
# n_iterations = 1000
# n = len(X)

# # Gradient Descent loop
# for i in range(n_iterations):
#     y_pred = w * X + b
#     error = y_pred - y
    
#     # Compute gradients
#     dw = (2/n) * np.dot(error, X)
#     db = (2/n) * np.sum(error)
    
#     # Update parameters
#     w -= learning_rate * dw
#     b -= learning_rate * db
    
#     if i % 100 == 0:
#         loss = (error ** 2).mean()
#         print(f"Iteration {i}: Loss = {loss:.4f}, w = {w:.4f}, b = {b:.4f}")

# # Final parameters
# print(f"Final parameters: w = {w:.4f}, b = {b:.4f}")

# # Plot results
# plt.scatter(X, y, label='Data')
# plt.plot(X, w*X + b, color='red', label='Fitted line')
# plt.xlabel('X')
# plt.ylabel('y')
# plt.legend()
# plt.show()

# # #--------------------------------------------------------------------
# # 2.Stochastic Gradient Descent Algorithm(SGD)
# import numpy as np
# import matplotlib.pyplot as plt

# # # Sample data
# # X = np.array([1, 2, 3])
# # y = np.array([3, 5, 7])


# # Sample data (linear with some noise)
# np.random.seed(42)
# X = 2 * np.random.rand(100)
# y = 4 + 3 * X + np.random.randn(100)

# # Initialize parameters
# w = 0.0
# b = 0.0
# learning_rate = 0.1
# n_epochs = 10

# n = len(X)

# for epoch in range(n_epochs):
#     for i in range(n):
#         x_i = X[i]
#         y_i = y[i]
        
#         # Prediction
#         y_pred = w * x_i + b
        
#         # Error
#         error = y_pred - y_i
        
#         # Gradients
#         dw = 2 * error * x_i
#         db = 2 * error
        
#         # Parameter updates
#         w -= learning_rate * dw
#         b -= learning_rate * db
    
#     # Print loss every epoch
#     y_preds = w * X + b
#     loss = ((y_preds - y) ** 2).mean()
#     print(f"Epoch {epoch+1}: Loss={loss:.4f}, w={w:.4f}, b={b:.4f}")

# print(f"\nFinal parameters: w={w:.4f}, b={b:.4f}")

# # Plot results
# plt.scatter(X, y, label='Data')
# plt.plot(X, w*X + b, color='red', label='Fitted line')
# plt.xlabel('X')
# plt.ylabel('y')
# plt.legend()
# plt.show()

# #-----------------------------------------------------------------------------
# # 3.Mini-batch Gradient Descent Algorithm (MSD)
# import numpy as np
# import matplotlib.pyplot as plt

# # Sample data
# X = np.array([1, 2, 3, 4])
# y = np.array([3, 5, 7, 9])

# # Initialize parameters
# w = 0.0
# b = 0.0
# learning_rate = 0.1
# batch_size = 2
# n_epochs = 5

# n = len(X)

# for epoch in range(n_epochs):
#     # Shuffle data at each epoch for better training
#     indices = np.random.permutation(n)
#     X_shuffled = X[indices]
#     y_shuffled = y[indices]
    
#     for start_idx in range(0, n, batch_size):
#         end_idx = start_idx + batch_size
#         xb = X_shuffled[start_idx:end_idx]
#         yb = y_shuffled[start_idx:end_idx]
        
#         # Predictions for the batch
#         y_pred = w * xb + b
        
#         # Errors
#         errors = y_pred - yb
        
#         # Gradients (mean over batch)
#         dw = 2 * np.mean(errors * xb)
#         db = 2 * np.mean(errors)
        
#         # Update parameters
#         w -= learning_rate * dw
#         b -= learning_rate * db
        
#     # Calculate loss over whole dataset for monitoring
#     y_preds = w * X + b
#     loss = np.mean((y_preds - y) ** 2)
#     print(f"Epoch {epoch+1}: Loss={loss:.4f}, w={w:.4f}, b={b:.4f}")

# print(f"\nFinal parameters after {n_epochs} epochs: w={w:.4f}, b={b:.4f}")

# # Plot results
# plt.scatter(X, y, label='Data')
# plt.plot(X, w*X + b, color='red', label='Fitted line')
# plt.xlabel('X')
# plt.ylabel('y')
# plt.legend()
# plt.show()


#-----------------------------------------------------------------------------
# # 4.Adaptive Gradient Algorithm (Adagrad)
# import numpy as np
# import matplotlib.pyplot as plt

# #Sample Data
# #x = 2
# #y = 4

# # Sample data (linear with some noise)
# np.random.seed(42)
# x = 2 * np.random.rand(100)
# y = 4 + 3 * x + np.random.randn(100)


# # Initialize parameter
# w = 0.0
# n=len(x)
# # Adagrad settings
# learning_rate = 1.0  # Adagrad usually uses higher initial learning rate
# epsilon = 1e-8       # Small constant to avoid division by zero
# G = 0                # Accumulated squared gradient

# # Run 2 iterations manually
# for t in range(n):
#     # Forward pass: prediction
#     y_pred = w * x
#     # Compute loss (optional, for monitoring)
#     loss = (y_pred - y) ** 2
#     # Compute gradient
#     grad = 2 * (y_pred - y) * x
#     # Accumulate squared gradients
#     G += grad ** 2
#     # Adagrad update
#     adjusted_lr = learning_rate / (np.sqrt(G) + epsilon)
#     w = w - adjusted_lr * grad

#     # # Print details
#     print(f"Iteration {t}")
#     print(f"Prediction: {y_pred:.4f}, Loss: {loss:.4f}") #error Occurs *************
#     # print(f"Gradient: {grad:.4f}")
#     # print(f"Accumulated Gradient (G): {G:.4f}")
#     # print(f"Adjusted Learning Rate: {adjusted_lr:.4f}")
#     # print(f"Updated w: {w:.4f}")
#     # print("-" * 40)


# ## Plot results
# # plt.scatter(x, y, label='Data')
# # plt.plot(x, w*x , color='red', label='Fitted line')
# # plt.xlabel('x')
# # plt.ylabel('y')
# # plt.legend()
# # plt.show()

#---------------------------------------------------------------------------
# # 5. Root Mean Square Propagation (RMSProp)

# import numpy as np

# # Data
# x = 2
# y = 4

# # Initialize parameter
# w = 0.0

# # RMSProp settings
# learning_rate = 0.1
# gamma = 0.9            # Decay rate
# epsilon = 1e-8         # Small number to prevent division by zero
# Eg2 = 0.0              # Running average of squared gradients

# # Run 2 iterations manually
# for t in range(1, 3):
#     # Prediction
#     y_pred = w * x
    
#     # Compute loss (optional)
#     loss = (y_pred - y) ** 2
    
#     # Gradient
#     grad = 2 * (y_pred - y) * x
    
#     # Update running average of squared gradients
#     Eg2 = gamma * Eg2 + (1 - gamma) * grad ** 2
    
#     # Update parameter
#     adjusted_lr = learning_rate / (np.sqrt(Eg2) + epsilon)
#     w = w - adjusted_lr * grad
    
#     # Print details
#     print(f"Iteration {t}")
#     print(f"Prediction: {y_pred:.4f}, Loss: {loss:.4f}")
#     print(f"Gradient: {grad:.4f}")
#     print(f"Running Avg of Squared Gradients (Eg2): {Eg2:.4f}")
#     print(f"Adjusted Learning Rate: {adjusted_lr:.4f}")
#     print(f"Updated w: {w:.4f}")
#     print("-" * 40)


#--------------------------------------------------------------------------------
# # 6. Adaptive Moment Estimation (ADAM)
# import numpy as np

# # Data
# x = 2
# y = 4

# # Initialize parameter and moments
# w = 0.0
# m = 0.0
# v = 0.0

# # Hyperparameters
# learning_rate = 0.1
# beta1 = 0.9
# beta2 = 0.999
# epsilon = 1e-8

# # Number of iterations
# num_iterations = 2

# for t in range(1, num_iterations + 1):
#     # Prediction
#     y_pred = w * x
    
#     # Compute gradient
#     grad = 2 * (y_pred - y) * x
    
#     # Update biased first moment estimate
#     m = beta1 * m + (1 - beta1) * grad
    
#     # Update biased second moment estimate
#     v = beta2 * v + (1 - beta2) * (grad ** 2)
    
#     # Compute bias-corrected first moment estimate
#     m_hat = m / (1 - beta1 ** t)
    
#     # Compute bias-corrected second moment estimate
#     v_hat = v / (1 - beta2 ** t)
    
#     # Update parameter
#     w = w - (learning_rate / (np.sqrt(v_hat) + epsilon)) * m_hat
    
#     # Print details
#     print(f"Iteration {t}")
#     print(f"Prediction: {y_pred:.4f}")
#     print(f"Gradient: {grad:.4f}")
#     print(f"m (1st moment): {m:.4f}")
#     print(f"v (2nd moment): {v:.4f}")
#     print(f"m_hat (bias corrected): {m_hat:.4f}")
#     print(f"v_hat (bias corrected): {v_hat:.4f}")
#     print(f"Updated w: {w:.4f}")
#     print("-" * 40)


# #--------------------------------------------------------------------------
# #Derivative-Free Algorithms:
# # 1.Genetic Algorithm
# import random

# # --- Helper functions ---

# def binary_to_decimal(b):
#     return int(b, 2)

# def decimal_to_binary(d, bits=5):
#     return format(d, f'0{bits}b')

# def fitness(x):
#     return x ** 2

# def create_population(size, bits=5):
#     return [decimal_to_binary(random.randint(0, 2**bits - 1), bits) for _ in range(size)]

# def selection(population, fitnesses):
#     total_fitness = sum(fitnesses)
#     probs = [f / total_fitness for f in fitnesses]
#     selected = random.choices(population, weights=probs, k=len(population))
#     return selected

# def crossover(parent1, parent2):
#     point = random.randint(1, len(parent1) - 1)
#     child1 = parent1[:point] + parent2[point:]
#     child2 = parent2[:point] + parent1[point:]
#     return child1, child2

# def mutate(binary_str, mutation_rate=0.01):
#     mutated = ''
#     for bit in binary_str:
#         if random.random() < mutation_rate:
#             mutated += '1' if bit == '0' else '0'
#         else:
#             mutated += bit
#     return mutated

# # --- GA parameters ---
# population_size = 4
# bits = 5
# generations = 5
# mutation_rate = 0.1  # 10% mutation chance for illustration

# # --- Initialize population ---
# population = create_population(population_size, bits)
# print("Initial population:")
# for ind in population:
#     print(ind, binary_to_decimal(ind), fitness(binary_to_decimal(ind)))

# # --- Run GA ---
# for gen in range(generations):
#     print(f"\nGeneration {gen+1}")
    
#     # Calculate fitness for the population
#     fitnesses = [fitness(binary_to_decimal(ind)) for ind in population]
    
#     # Selection
#     selected = selection(population, fitnesses)
    
#     # Crossover (pairwise)
#     next_generation = []
#     for i in range(0, population_size, 2):
#         parent1 = selected[i]
#         parent2 = selected[(i+1) % population_size]  # wrap around if odd size
#         child1, child2 = crossover(parent1, parent2)
#         next_generation.extend([child1, child2])
    
#     # Mutation
#     next_generation = [mutate(child, mutation_rate) for child in next_generation]
    
#     # Replace old population with new
#     population = next_generation[:population_size]
    
#     # Print population info
#     for ind in population:
#         dec = binary_to_decimal(ind)
#         print(ind, dec, fitness(dec))


# #--------------------------------------------------------------------------
# # 2. Nelder-Mead algorithm
# import numpy as np

# def f(point):
#     x, y = point
#     return (x - 1)**2 + (y - 2)**2

# # Nelder-Mead Parameters
# alpha = 1      # Reflection coefficient
# gamma = 2      # Expansion coefficient
# rho = 0.5      # Contraction coefficient
# sigma = 0.5    # Shrink coefficient

# # Initial simplex: 3 points in 2D
# simplex = [
#     np.array([0.0, 0.0]),
#     np.array([1.0, 0.0]),
#     np.array([0.0, 1.0])
# ]

# def order_simplex(simplex):
#     return sorted(simplex, key=lambda point: f(point))

# def centroid(points):
#     return np.mean(points, axis=0)

# def nelder_mead(simplex, max_iter=10):
#     for iteration in range(max_iter):
#         simplex = order_simplex(simplex)
#         best = simplex[0]
#         second = simplex[1]
#         worst = simplex[2]

#         print(f"\nIteration {iteration + 1}")
#         print("Simplex:")
#         for point in simplex:
#             print(f"  Point: {point}, f = {f(point):.4f}")

#         # Centroid of best and second best
#         c = centroid([best, second])

#         # Reflection
#         xr = c + alpha * (c - worst)
#         fr = f(xr)

#         if fr < f(best):
#             # Expansion
#             xe = c + gamma * (xr - c)
#             fe = f(xe)
#             if fe < fr:
#                 simplex[2] = xe
#                 print("  Expansion accepted.")
#             else:
#                 simplex[2] = xr
#                 print("  Reflection accepted (better than best).")
#         elif f(best) <= fr < f(second):
#             simplex[2] = xr
#             print("  Reflection accepted.")
#         else:
#             # Contraction
#             xc = c + rho * (worst - c)
#             fc = f(xc)
#             if fc < f(worst):
#                 simplex[2] = xc
#                 print("  Contraction accepted.")
#             else:
#                 # Shrink
#                 print("  Shrinking simplex.")
#                 simplex[1] = best + sigma * (simplex[1] - best)
#                 simplex[2] = best + sigma * (simplex[2] - best)

#     # Final output
#     best_point = order_simplex(simplex)[0]
#     print(f"\nBest point found: {best_point}, f = {f(best_point):.4f}")
#     return best_point

# # Run the algorithm
# nelder_mead(simplex, max_iter=10)

#-------------------------------------------------------------------------------
# 3. Simulated Annealing

# # 3.1 1D Objective Function
# import numpy as np

# def f(x):
#     return (x - 3)**2

# # Initialize
# x = 0.0  # start point
# T = 10.0
# T_min = 1.0
# alpha = 0.8
# step_size = 1.0

# np.random.seed(1)

# print(f"Initial position: x = {x:.2f}, f(x) = {f(x):.4f}")

# for i in range(1, 6):
#     # Propose new point
#     x_new = x + np.random.uniform(-step_size, step_size)
#     f_current = f(x)
#     f_new = f(x_new)

#     print(f"\nIteration {i}:")
#     print(f"Proposed x_new = {x_new:.2f}, f(x_new) = {f_new:.4f}")

#     if f_new < f_current:
#         print("Accepted (better)")
#         x = x_new
#     else:
#         prob = np.exp(-(f_new - f_current) / T)
#         rand = np.random.rand()
#         print(f"Worse solution. Acceptance prob = {prob:.4f}, Random = {rand:.4f}")
#         if rand < prob:
#             print("Accepted (probabilistic)")
#             x = x_new
#         else:
#             print("Rejected")

#     print(f"Current position: x = {x:.2f}, f(x) = {f(x):.4f}")

#     T *= alpha
#     if T < T_min:
#         break
# #----------------------------------------

# # 3.2 2D Objective Function
# import numpy as np

# # Objective function
# def f(x, y):
#     return (x - 1)**2 + (y - 2)**2

# # Initial point
# x, y = 4.0, -3.0
# T = 10.0
# T_min = 1.0
# alpha = 0.9
# step_size = 1.0

# np.random.seed(42)  # For reproducibility

# print(f"Initial position: x = {x:.2f}, y = {y:.2f}, f = {f(x, y):.4f}")

# # Manual iterations
# for i in range(1, 6):
#     # Propose new point
#     dx = np.random.uniform(-step_size, step_size)
#     dy = np.random.uniform(-step_size, step_size)
#     x_new = x + dx
#     y_new = y + dy
#     f_current = f(x, y)
#     f_new = f(x_new, y_new)

#     print(f"\nIteration {i}:")
#     print(f"Proposed move: dx = {dx:.2f}, dy = {dy:.2f}")
#     print(f"New position: x = {x_new:.2f}, y = {y_new:.2f}, f = {f_new:.4f}")

#     # Acceptance logic
#     if f_new < f_current:
#         print("Accepted (better)")
#         x, y = x_new, y_new
#     else:
#         prob = np.exp(-(f_new - f_current) / T)
#         rand = np.random.rand()
#         print(f"Worse solution. Acceptance probability = {prob:.4f}, Random = {rand:.4f}")
#         if rand < prob:
#             print("Accepted (by probability)")
#             x, y = x_new, y_new
#         else:
#             print("Rejected")

#     print(f"Current position: x = {x:.2f}, y = {y:.2f}, f = {f(x, y):.4f}")

#     # Cool down
#     T *= alpha
#     if T < T_min:
#         break
# #--------------------------------------

# #3.3 Travelling Salesman Problem
# import numpy as np
# import matplotlib.pyplot as plt

# # Generate random 2D cities
# num_cities = 10
# cities = np.random.rand(num_cities, 2)

# # Calculate distance matrix
# def total_distance(route):
#     return sum(np.linalg.norm(cities[route[i]] - cities[route[(i+1) % num_cities]])
#                for i in range(num_cities))

# # Initialize
# current_route = list(range(num_cities))
# np.random.shuffle(current_route)
# best_route = current_route[:]
# best_dist = total_distance(best_route)

# T = 100
# T_min = 1e-3
# alpha = 0.995

# # Simulated Annealing
# while T > T_min:
#     i, j = np.random.randint(0, num_cities, size=2)
#     new_route = current_route[:]
#     new_route[i], new_route[j] = new_route[j], new_route[i]
#     new_dist = total_distance(new_route)
    
#     if new_dist < total_distance(current_route) or \
#        np.random.rand() < np.exp(-(new_dist - total_distance(current_route)) / T):
#         current_route = new_route[:]
#         if new_dist < best_dist:
#             best_dist = new_dist
#             best_route = new_route[:]
    
#     T *= alpha

# # Plot
# plt.figure(figsize=(8, 6))
# ordered_cities = cities[best_route + [best_route[0]]]  # loop back
# plt.plot(ordered_cities[:, 0], ordered_cities[:, 1], 'o-', label='Best Route')
# plt.title(f"Best distance: {best_dist:.2f}")
# plt.legend()
# plt.grid(True)
# plt.show()

#-----------------------------------------------------------------------
# #4. Particle Swarm Optimization

# import numpy as np
# import matplotlib.pyplot as plt
# from matplotlib.widgets import Slider, Button

# # Objective function
# def f(position):
#     return (position[0] - 1)**2 + (position[1] + 2)**2

# # PSO parameters and state — will be reset on slider update
# num_particles = 15
# dim = 2
# max_iter = 200

# def init_particles():
#     positions = np.random.uniform(-10, 10, (num_particles, dim))
#     velocities = np.zeros((num_particles, dim))
#     pbest_positions = positions.copy()
#     pbest_scores = np.array([f(pos) for pos in positions])
#     gbest_index = np.argmin(pbest_scores)
#     gbest_position = pbest_positions[gbest_index].copy()
#     gbest_score = pbest_scores[gbest_index]
#     return positions, velocities, pbest_positions, pbest_scores, gbest_position, gbest_score

# positions, velocities, pbest_positions, pbest_scores, gbest_position, gbest_score = init_particles()
# current_iter = 0
# running = False  # For play/pause state

# # Setup plot
# fig, ax = plt.subplots(figsize=(8, 6))
# plt.subplots_adjust(left=0.1, bottom=0.3)

# x_vals = np.linspace(-12, 14, 200)
# y_vals = np.linspace(-14, 10, 200)
# X, Y = np.meshgrid(x_vals, y_vals)
# Z = (X - 1)**2 + (Y + 2)**2

# contour = ax.contour(X, Y, Z, levels=50, cmap='viridis')
# particles_scatter = ax.scatter(positions[:, 0], positions[:, 1], c='red', label='Particles')
# pbest_scatter = ax.scatter(pbest_positions[:, 0], pbest_positions[:, 1], c='blue', marker='x', label='Personal Bests')
# gbest_scatter = ax.scatter(gbest_position[0], gbest_position[1], c='gold', marker='*', s=150, label='Global Best')

# ax.set_xlim([-12, 14])
# ax.set_ylim([-14, 10])
# ax.set_title("Particle Swarm Optimization with Interactive Parameters")
# ax.legend()

# # Sliders for parameters
# axcolor = 'lightgoldenrodyellow'
# ax_w = plt.axes([0.1, 0.2, 0.8, 0.03], facecolor=axcolor)
# ax_c1 = plt.axes([0.1, 0.15, 0.8, 0.03], facecolor=axcolor)
# ax_c2 = plt.axes([0.1, 0.1, 0.8, 0.03], facecolor=axcolor)

# slider_w = Slider(ax_w, 'Inertia (w)', 0.0, 1.0, valinit=0.7, valstep=0.01)
# slider_c1 = Slider(ax_c1, 'Cognitive (c1)', 0.0, 3.0, valinit=1.5, valstep=0.01)
# slider_c2 = Slider(ax_c2, 'Social (c2)', 0.0, 3.0, valinit=1.5, valstep=0.01)

# iteration_text = ax.text(0.02, 0.95, '', transform=ax.transAxes)

# def reset_particles(val=None):
#     global positions, velocities, pbest_positions, pbest_scores, gbest_position, gbest_score, current_iter
#     positions, velocities, pbest_positions, pbest_scores, gbest_position, gbest_score = init_particles()
#     current_iter = 0
#     update_plot()
    
# def update_plot():
#     particles_scatter.set_offsets(positions)
#     pbest_scatter.set_offsets(pbest_positions)
#     gbest_scatter.set_offsets([gbest_position])
#     iteration_text.set_text(f"Iteration: {current_iter}\nGlobal Best: {gbest_score:.4f}")
#     fig.canvas.draw_idle()

# slider_w.on_changed(reset_particles)
# slider_c1.on_changed(reset_particles)
# slider_c2.on_changed(reset_particles)

# def step_iteration():
#     global positions, velocities, pbest_positions, pbest_scores, gbest_position, gbest_score, current_iter
#     if current_iter >= max_iter:
#         return
    
#     w = slider_w.val
#     c1 = slider_c1.val
#     c2 = slider_c2.val
    
#     for i in range(num_particles):
#         r1, r2 = np.random.rand(dim), np.random.rand(dim)
#         velocities[i] = (w * velocities[i] +
#                          c1 * r1 * (pbest_positions[i] - positions[i]) +
#                          c2 * r2 * (gbest_position - positions[i]))
#         positions[i] += velocities[i]
        
#         score = f(positions[i])
#         if score < pbest_scores[i]:
#             pbest_positions[i] = positions[i].copy()
#             pbest_scores[i] = score
    
#     gbest_index = np.argmin(pbest_scores)
#     if pbest_scores[gbest_index] < gbest_score:
#         gbest_position = pbest_positions[gbest_index].copy()
#         gbest_score = pbest_scores[gbest_index]
    
#     current_iter += 1
#     update_plot()

# def on_step_clicked(event):
#     global running
#     if not running:  # Only step if not running automatically
#         step_iteration()

# def on_play_clicked(event):
#     global running
#     running = not running
#     if running:
#         button_play.label.set_text("Pause")
#     else:
#         button_play.label.set_text("Play")

# button_ax_step = plt.axes([0.25, 0.025, 0.2, 0.04])
# button_step = Button(button_ax_step, 'Step Iteration')
# button_step.on_clicked(on_step_clicked)

# button_ax_play = plt.axes([0.55, 0.025, 0.2, 0.04])
# button_play = Button(button_ax_play, 'Play')
# button_play.on_clicked(on_play_clicked)

# def animate(frame):
#     if running and current_iter < max_iter:
#         step_iteration()

# # Use matplotlib's animation framework for the play functionality
# from matplotlib.animation import FuncAnimation
# anim = FuncAnimation(fig, animate, interval=100)

# plt.show()
