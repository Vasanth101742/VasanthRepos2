

# # 1. Find out Eigen Value and Eigen Vector of a given Matrix
# import numpy as np
# # Define a square matrix
# # A = np.array([[4, 2],
# #               [1, 3]])

# A = np.array([[4, 2,5],
#               [1, 3,7],
#               [6,4,1]])
# # Calculate eigenvalues and eigenvectors
# eigenvalues, eigenvectors = np.linalg.eig(A)

# print("Eigenvalues:")
# print(eigenvalues)

# print("\nEigenvectors:")
# print(eigenvectors)

# #------------------------------------------------------------------
# # Principal Component Analysis
# import numpy as np
# from sklearn.datasets import fetch_olivetti_faces
# import matplotlib.pyplot as plt

# # Load sample face dataset (images are 64x64 pixels)
# faces = fetch_olivetti_faces(shuffle=True, random_state=42)
# X = faces.data  # shape (400, 4096) => 400 images flattened
# #print(type(X))
# #input()
# #print(X)

# images = X.reshape(-1, 64, 64)  # reshape flat vectors into 64x64 images
# #print(images)

# # Plot the first 16 sample faces
# fig, axes = plt.subplots(4, 4, figsize=(8, 8),
#                          subplot_kw={'xticks': [], 'yticks': []})
# for i, ax in enumerate(axes.flat):
#     ax.imshow(images[i], cmap='gray')
#     ax.set_title(f"Face {i+1}")

# plt.suptitle("Sample Faces from Olivetti Dataset", fontsize=16)
# plt.tight_layout()
# #plt.show()
# #input()

# # Center the data by subtracting the mean face
# mean_face = np.mean(X, axis=0)
# X_centered = X - mean_face

# # Compute covariance matrix
# cov_matrix = np.cov(X_centered, rowvar=False)

# # Calculate eigenvalues and eigenvectors of the covariance matrix
# eigenvalues, eigenvectors = np.linalg.eigh(cov_matrix)

# # Sort eigenvectors by decreasing eigenvalues
# sorted_idx = np.argsort(eigenvalues)[::-1]
# eigenvalues = eigenvalues[sorted_idx]
# eigenvectors = eigenvectors[:, sorted_idx]
# # print(type(eigenvalues))
# # print(type(eigenvectors))
# # input()


# # Visualize the top 5 eigenfaces
# fig, axes = plt.subplots(1, 5, figsize=(15, 5))
# for i in range(5):
#     eigenface = eigenvectors[:, i].reshape(64, 64)
#     axes[i].imshow(eigenface, cmap='gray')
#     axes[i].set_title(f"Eigenface {i+1}")
#     axes[i].axis('off')

# plt.show()

# #------------------------------------------------------------------
# #For 2D vectors (2x2 matrix eigenvectors):

# import numpy as np
# import matplotlib.pyplot as plt

# v = np.array([2, 3])  # Example eigenvector

# plt.quiver(0, 0, v[0], v[1], angles='xy', scale_units='xy', scale=1, color='r')
# plt.xlim(-4, 4)
# plt.ylim(-4, 4)
# plt.grid(True)
# plt.xlabel('x')
# plt.ylabel('y')
# plt.title('Eigenvector Visualization in 2D')
# plt.show()

# #--------------------------------------------------------------------------------------
# #For 3D vectors (3x3 matrix eigenvectors):

# from mpl_toolkits.mplot3d import Axes3D
# import matplotlib.pyplot as plt
# import numpy as np

# v = np.array([1, 2, 3])

# fig = plt.figure()
# ax = fig.add_subplot(111, projection='3d')

# ax.quiver(0, 0, 0, v[0], v[1], v[2], color='b')
# ax.set_xlim([-4, 4])
# ax.set_ylim([-4, 4])
# ax.set_zlim([-4, 4])
# ax.set_xlabel('X')
# ax.set_ylabel('Y')
# ax.set_zlabel('Z')
# plt.title('Eigenvector Visualization in 3D')
# plt.show()


# #-------------------------------------------------------------------------
# # #How to project data points into eigenspace

# # 1.Center your data:
# # 2.Form a matrix of eigenvectors:
# # 3.Project data points:


# import numpy as np

# # Suppose X is your data matrix (n samples x d features)
# X = np.array([[2.5, 2.4],
#               [0.5, 0.7],
#               [2.2, 2.9],
#               [1.9, 2.2],
#               [3.1, 3.0]])

# # Step 1: Center the data
# X_mean = np.mean(X, axis=0)
# X_centered = X - X_mean

# # Assume you already have eigenvectors from covariance matrix decomposition
# # For example, eigenvectors for 2D data (2 x 2 matrix)
# # Let's just define them manually or compute via np.linalg.eig:

# #Because the covariance matrix encodes how features vary together, 
# #and its eigenvectors point in the directions of maximum variance — which is 
# #exactly what PCA (and similar methods) is looking for.

# cov = np.cov(X_centered, rowvar=False)
# eig_vals, eig_vecs = np.linalg.eig(cov)

# # Sort eigenvectors by eigenvalues descending
# idx = eig_vals.argsort()[::-1]
# eig_vecs = eig_vecs[:, idx]
# print("\nAvailable Eigen Vectors :\n",eig_vecs)

# # Select top k eigenvectors (here k=2 for full)
# V = eig_vecs[:, :2]
# print("\nTop Eigen Vectors :\n",V)
# # Step 3: Project data
# Y = np.dot(X_centered, V)

# print("\nProjected Data in Eigen space:\n", Y)

#--------------------------------------------------------------------------------
#Elements Fetching in the Matrix
# import numpy as np

# eig_vecs = np.array([
#     [1, 2, 3],
#     [4, 5, 6],
#     [7, 8, 9]
# ])

# print("eig_vecs[:,0]:\n", eig_vecs[:,0]) #[1 4 7]
# print("eig_vecs[:,1]:\n", eig_vecs[:,1]) #[2 5 8]
# print("eig_vecs[:,2]:\n", eig_vecs[:,2]) #[3 6 9]
# print("eig_vecs[:,:2]:\n", eig_vecs[:,:2]) #[[1 2]
#                                            # [4 5]
#                                            # [7 8]]
# print("eig_vecs[::2]:\n", eig_vecs[::2]) #[[1 2 3]
#                                          # [7 8 9]]



#-----------------------------------------------------------------------------
# #Visualizing a 2D linear transformation and its eigenvectors

# #Step 1: Plot original points and transformed points

# #Draw a grid of points.
# #Apply transformation Matrix A
# #Plot both to see how A warps the space.

# #Step 2: Compute eigenvectors and eigenvalues
# #Step 3: Show how transformation acts as scaling along eigenvectors

# import numpy as np
# import matplotlib.pyplot as plt

# # Define matrix A
# A = np.array([[3, 1],
#               [0, 2]])

# # Generate grid points
# x_vals = np.linspace(-2, 2, 10)
# y_vals = np.linspace(-2, 2, 10)
# X, Y = np.meshgrid(x_vals, y_vals)
# points = np.vstack([X.ravel(), Y.ravel()])

# # Transform points
# transformed_points = A @ points

# # Compute eigenvalues and eigenvectors
# eig_vals, eig_vecs = np.linalg.eig(A)

# # Plot original points (blue) and transformed points (red)
# plt.figure(figsize=(8, 8))
# plt.scatter(points[0, :], points[1, :], color='blue', alpha=0.5, label='Original points')
# plt.scatter(transformed_points[0, :], transformed_points[1, :], color='red', alpha=0.5, label='Transformed points')

# # Plot eigenvectors starting from origin
# origin = np.array([[0, 0], [0, 0]])
# for i in range(len(eig_vals)):
#     vec = eig_vecs[:, i] * 3  # scale for visibility
#     plt.quiver(*origin[:, 0], vec[0], vec[1], angles='xy', scale_units='xy', scale=1, color='green', label=f'Eigenvector {i+1}' if i == 0 else "")

# plt.axhline(0, color='gray', lw=1)
# plt.axvline(0, color='gray', lw=1)
# plt.grid(True)
# plt.axis('equal')
# plt.legend()
# plt.title('Linear Transformation and Its Eigenvectors')
# plt.show()


# #------------------------------------------------------------------------
# #SVD on a small matrix

# import numpy as np
# import matplotlib.pyplot as plt

# # Sample matrix X (say, 4 samples, 3 features)
# X = np.array([
#     [3, 1, 1],
#     [-1, 3, 1],
#     [3, 1, -1],
#     [-1, -3, 1]
# ])

# # Compute SVD
# U, S, VT = np.linalg.svd(X, full_matrices=False)

# print("Matrix X:\n", X)
# print("\nLeft singular matrix U (shape {}):\n{}".format(U.shape, U))
# print("\nSingular values S:\n", S)
# print("\nRight singular matrix V (shape {}):\n{}".format(VT.T.shape, VT.T))

# # Reconstruction from SVD
# Sigma = np.diag(S)
# X_reconstructed = U @ Sigma @ VT

# print("\nReconstructed X (U * Sigma * VT):\n", X_reconstructed)

# # Plot the first two right singular vectors (columns of V)
# plt.figure(figsize=(6,4))
# plt.quiver(0, 0, VT[0,0], VT[0,1], angles='xy', scale_units='xy', scale=1, color='r', label='V[:,0]')
# plt.quiver(0, 0, VT[1,0], VT[1,1], angles='xy', scale_units='xy', scale=1, color='g', label='V[:,1]')
# #plt.quiver(0, 0, VT[2,0], VT[2,1], angles='xy', scale_units='xy', scale=1, color='g', label='V[:,2]')
# #plt.quiver(0, 0, VT[3,0], VT[3,1], angles='xy', scale_units='xy', scale=1, color='g', label='V[:,3]')
# plt.xlim(-1,1)
# plt.ylim(-1,1)
# plt.grid()
# plt.legend()
# plt.title('First two right singular vectors (feature patterns)')
# plt.show()

# #----------------------------------------------------------------------------
# #Step-by-step PCA without sklearn PCA function (using SVD)

# #Step 1: Import libraries and load data

# import numpy as np
# import matplotlib.pyplot as plt
# from sklearn.datasets import load_digits
# from sklearn.preprocessing import StandardScaler

# # Load digits dataset
# digits = load_digits()
# X = digits.data
# y = digits.target

# #Step 2: Standardize the data

# scaler = StandardScaler()
# X_scaled = scaler.fit_transform(X)

# #Step 3: Compute covariance matrix

# # Since X_scaled is zero mean, covariance matrix is:
# cov_matrix = np.cov(X_scaled, rowvar=False)  # shape (64, 64)

# #Step 4: Compute eigenvalues and eigenvectors of covariance matrix

# eigvals, eigvecs = np.linalg.eigh(cov_matrix)
# #Note: Use np.linalg.eigh since covariance matrix is symmetric.

# #Step 5: Sort eigenvalues and eigenvectors in descending order

# sorted_idx = np.argsort(eigvals)[::-1]
# eigvals = eigvals[sorted_idx]
# eigvecs = eigvecs[:, sorted_idx]

# #Step 6: Select top k eigenvectors (principal components)

# k = 2
# top_eigvecs = eigvecs[:, :k]  # shape (64, 2)

# #Step 7: Project data onto principal components

# X_pca_manual = X_scaled @ top_eigvecs  # shape (1797, 2)

# X_pca_manual = X_scaled @ top_eigvecs  # shape (1797, 2)

# #Step 8: Explained variance ratio
# explained_variance_ratio = eigvals[:k] / np.sum(eigvals)
# print("Explained variance ratio (manual PCA):", explained_variance_ratio)
# print("Total explained variance:", np.sum(explained_variance_ratio))

# #Step 9: Visualize PCA projection

# plt.figure(figsize=(10,8))
# scatter = plt.scatter(X_pca_manual[:, 0], X_pca_manual[:, 1], c=y, cmap='tab10', alpha=0.7)
# plt.colorbar(scatter, ticks=range(10))
# plt.xlabel('Principal Component 1')
# plt.ylabel('Principal Component 2')
# plt.title('Manual PCA on Digits Dataset')
# plt.grid(True)
# plt.show()

# # Summary:
# # We standardized data
# # Computed covariance matrix
# # Got eigenvalues & eigenvectors of covariance matrix
# # Sorted, selected top components
# # Projected data onto those eigenvectors for dimensionality reduction
# # Visualized the results

# #*******************
# #Image Reconstruction from PCA Components (Manual PCA)
# #We’ll take the reduced 2D representation and try to reconstruct the original 64D images approximately.


# #Step 1: Project data onto principal components (already done)

# #X_pca_manual = X_scaled @ top_eigvecs  # shape (1797, 2)

# #Step 2: Reconstruct data from PCA components
# #To reconstruct, multiply back by the transpose of the eigenvectors:

# X_reconstructed_scaled = X_pca_manual @ top_eigvecs.T  # shape (1797, 64)

# #Step 3: Reverse standardization (scale back to original pixel values)
# #Recall we standardized data with StandardScaler. To get back to original scale:

# # Use scaler parameters to invert transform
# X_reconstructed = scaler.inverse_transform(X_reconstructed_scaled)

# #Step 4: Visualize original vs reconstructed images

# import matplotlib.pyplot as plt

# n = 10  # number of digits to display
# plt.figure(figsize=(20, 4))

# for i in range(n):
#     # Original image
#     ax = plt.subplot(2, n, i + 1)
#     plt.imshow(X[i].reshape(8, 8), cmap='gray')
#     plt.title(f"Original: {y[i]}")
#     plt.axis('off')

#     # Reconstructed image
#     ax = plt.subplot(2, n, i + 1 + n)
#     plt.imshow(X_reconstructed[i].reshape(8, 8), cmap='gray')
#     plt.title("Reconstructed")
#     plt.axis('off')

# plt.suptitle('Original vs Reconstructed Images from 2 PCA Components')
# plt.show()

# #What you’ll see:
# #Top row: original handwritten digit images.
# #Bottom row: reconstructed images using only 2 principal components.
# #Reconstruction won’t be perfect but captures major patterns.

#-----------------------------------------------------------------------------
# #Singular Value Decomposition : Visualization

# import numpy as np
# import matplotlib.pyplot as plt

# # Step 1: Create a unit circle
# theta = np.linspace(0, 2 * np.pi, 200)
# circle = np.vstack((np.cos(theta), np.sin(theta)))  # shape: (2, 200)

# # Step 2: Define a transformation matrix A
# A = np.array([
#     [3, 1],
#     [1, 3]
# ])

# # Step 3: Perform SVD
# U, S, VT = np.linalg.svd(A)
# Sigma = np.diag(S)

# # Step 4: Apply transformations
# circle_VT = VT @ circle       # Rotate input circle by V^T
# circle_scaled = Sigma @ circle_VT  # Scale the result by Σ
# circle_transformed = U @ circle_scaled  # Final rotation by U

# # Step 5: Plot
# fig, axes = plt.subplots(1, 4, figsize=(16, 4))
# titles = ['Original Unit Circle', 'After V^T', 'After Σ (Scaling)', 'After U (Final Result)']
# data = [circle, circle_VT, circle_scaled, circle_transformed]

# for ax, d, title in zip(axes, data, titles):
#     ax.plot(d[0], d[1], 'b')
#     ax.set_aspect('equal')
#     ax.grid(True)
#     ax.set_title(title)
#     ax.axhline(0, color='gray', lw=0.5)
#     ax.axvline(0, color='gray', lw=0.5)
#     ax.set_xlim(-5, 5)
#     ax.set_ylim(-5, 5)

# plt.tight_layout()
# plt.show()

#-----------------------------------------------------------------------------------
#Practical Application: Image Compression with SVD

#what this does :
#The image is decomposed into its singular components.
#You reconstruct the image using only the top 𝑘 singular values:
#Lower k → more compression, less detail.
#Higher k → better quality, less compression.

#Why It Works:
#SVD captures the most important structures in the image. 
# The first few singular values represent most of the visual content, 
# so you can discard the rest without a huge loss in quality.

#🧠 Practical Takeaway:
#You can compress images or datasets by keeping only the top components of SVD, which helps with:
# Saving space
# Speeding up computation
# Removing noise or redundancy


# import numpy as np
# import matplotlib.pyplot as plt
# from skimage import io, color
# from skimage.transform import resize

# # Load a grayscale image (or convert color image to grayscale)
# url = 'https://upload.wikimedia.org/wikipedia/commons/7/7d/Lenna_%28test_image%29.png'
# image = io.imread(url)
# gray = color.rgb2gray(image)

# # Resize image for faster computation
# gray = resize(gray, (256, 256), anti_aliasing=True)

# # Perform SVD
# U, S, VT = np.linalg.svd(gray, full_matrices=False)

# # Function to reconstruct image using top k singular values
# def reconstruct_image(U, S, VT, k):
#     S_k = np.diag(S[:k])
#     U_k = U[:, :k]
#     VT_k = VT[:k, :]
#     return U_k @ S_k @ VT_k

# # Plot original and compressed versions
# ks = [5, 20, 50, 100, 200]
# fig, axes = plt.subplots(1, len(ks)+1, figsize=(15, 5))

# # Original
# axes[0].imshow(gray, cmap='gray')
# axes[0].set_title("Original")
# axes[0].axis('off')

# # Compressed versions
# for i, k in enumerate(ks):
#     compressed = reconstruct_image(U, S, VT, k)
#     axes[i+1].imshow(compressed, cmap='gray')
#     axes[i+1].set_title(f'k = {k}')
#     axes[i+1].axis('off')

# plt.tight_layout()
# plt.show()

# #-----------------------------------------------------------------------------
#Color Image Compression Using SVD in Python

#How it works:
#A color image has 3 channels: Red, Green, and Blue.
#You apply SVD separately to each channel.
#Compress each channel by keeping top 𝑘 singular values.
#Recombine channels to get the compressed color image.

#What you'll observe:
# At low  𝑘 (like 5 or 20), image looks blurry but recognizable.
# At higher 𝑘 (like 50 or 100), image quality gets close to original.
# This compresses the image data while preserving essential visual info.


# import numpy as np
# import matplotlib.pyplot as plt
# from skimage import io
# from skimage.transform import resize

# # Load the color image
# url = 'https://upload.wikimedia.org/wikipedia/commons/7/7d/Lenna_%28test_image%29.png'
# image = io.imread(url)

# # Resize for faster processing
# image = resize(image, (256, 256), anti_aliasing=True)

# # Function to compress a single channel with SVD
# def compress_channel(channel, k):
#     U, S, VT = np.linalg.svd(channel, full_matrices=False)
#     S_k = np.diag(S[:k])
#     U_k = U[:, :k]
#     VT_k = VT[:k, :]
#     return U_k @ S_k @ VT_k

# # Compress each channel separately
# ks = [5, 20, 50, 100]
# fig, axes = plt.subplots(1, len(ks)+1, figsize=(15, 5))

# # Original image
# axes[0].imshow(image)
# axes[0].set_title("Original")
# axes[0].axis('off')

# # Apply compression for different k
# for i, k in enumerate(ks):
#     compressed_img = np.zeros_like(image)
#     for c in range(3):  # for each color channel
#         compressed_img[:, :, c] = compress_channel(image[:, :, c], k)
    
#     # Clip values to valid range [0,1]
#     compressed_img = np.clip(compressed_img, 0, 1)
    
#     axes[i+1].imshow(compressed_img)
#     axes[i+1].set_title(f'k = {k}')
#     axes[i+1].axis('off')

# plt.tight_layout()
# plt.show()

#--------------------------------------------------------------------------------
#PCA Using SVD Technique:

#Why PCA with SVD?
#PCA finds directions (principal components) that capture most variance.
#You can compute PCA by performing SVD on the centered data matrix.
#Top singular vectors correspond to principal directions.

#What’s Happening:
#We center the data (zero mean).
#Perform SVD on the centered data.
#Take the first two singular vectors (directions of max variance).
#Project the data onto these two vectors.
#Plot 2D scatter to visualize class separation.


# import numpy as np
# import matplotlib.pyplot as plt
# from sklearn.datasets import load_iris

# # Load Iris dataset
# data = load_iris()
# X = data.data  # shape (150, 4)
# y = data.target
# target_names = data.target_names

# # Step 1: Center the data (subtract mean)
# X_centered = X - np.mean(X, axis=0)

# # Step 2: Compute SVD
# U, S, VT = np.linalg.svd(X_centered, full_matrices=False)

# # Step 3: Project data onto first 2 principal components
# PCs = VT[:2]  # top 2 right singular vectors (principal directions)
# X_pca = X_centered @ PCs.T

# # Step 4: Plot the results
# plt.figure(figsize=(8,6))

# for target, color, label in zip(np.unique(y), ['r', 'g', 'b'], target_names):
#     plt.scatter(X_pca[y == target, 0], X_pca[y == target, 1], c=color, label=label)

# plt.xlabel('Principal Component 1')
# plt.ylabel('Principal Component 2')
# plt.title('PCA of Iris Dataset using SVD')
# plt.legend()
# plt.grid(True)
# plt.show()

# #-------------------------------------------------------------------------------------
# #PCA on a bigger dataset

# # What you’ll see:
# #The scatter plot with clusters for 3 wine classes, showing how PCA separates them.
# # The explained variance tells you how much info is retained by each principal component.

# import numpy as np
# import matplotlib.pyplot as plt
# from sklearn.datasets import load_wine

# # Load the Wine dataset
# data = load_wine()
# X = data.data   # shape (178, 13)
# y = data.target
# target_names = data.target_names

# # Step 1: Center the data
# X_centered = X - np.mean(X, axis=0)

# # Step 2: Compute SVD
# U, S, VT = np.linalg.svd(X_centered, full_matrices=False)

# # Step 3: Project data onto first 2 principal components
# PCs = VT[:2]  # top 2 principal directions
# X_pca = X_centered @ PCs.T

# # Step 4: Plot results
# plt.figure(figsize=(8,6))

# for target, color, label in zip(np.unique(y), ['r', 'g', 'b'], target_names):
#     plt.scatter(X_pca[y == target, 0], X_pca[y == target, 1], c=color, label=label)

# plt.xlabel('Principal Component 1')
# plt.ylabel('Principal Component 2')
# plt.title('PCA of Wine Dataset using SVD')
# plt.legend()
# plt.grid(True)
# plt.show()

# # How much variance each PC explains

# explained_variance = (S ** 2) / (len(X) - 1)
# explained_variance_ratio = explained_variance / explained_variance.sum()

# print("Explained variance ratio of first 5 components:")
# for i, ratio in enumerate(explained_variance_ratio[:5], start=1):
#     print(f"PC{i}: {ratio:.4f}")

#---------------------------------------------------------------------------------------
# # Reduce dimensions further and cluster the data

# #Let’s take the Wine dataset PCA further by:
# #Reducing dimensions (to 2D or 3D), and
# #Clustering the data (using K-Means), then
# #Visualizing the clusters to see how well they align with the original classes.

# #What this does:
# #PCA reduces features from 13 → 2 (easier to visualize and cluster).
# #KMeans clusters the 2D data into 3 groups (since wine dataset has 3 classes).
# #Side-by-side plots show:
# # True labels (based on actual wine types)
# # Clusters found by KMeans


# import numpy as np
# import matplotlib.pyplot as plt
# from sklearn.datasets import load_wine
# from sklearn.cluster import KMeans

# # Load data
# data = load_wine()
# X = data.data
# y = data.target
# target_names = data.target_names

# # Step 1: Center the data
# X_centered = X - np.mean(X, axis=0)

# # Step 2: Compute SVD and reduce to 2D
# U, S, VT = np.linalg.svd(X_centered, full_matrices=False)
# PCs = VT[:2]
# X_pca = X_centered @ PCs.T

# # Step 3: Cluster reduced data with KMeans (3 clusters for 3 classes)
# kmeans = KMeans(n_clusters=3, random_state=42)
# clusters = kmeans.fit_predict(X_pca)

# # Step 4: Plot true classes vs clusters side by side

# fig, axes = plt.subplots(1, 2, figsize=(14,6))

# # Plot actual classes
# for target, color, label in zip(np.unique(y), ['r', 'g', 'b'], target_names):
#     axes[0].scatter(X_pca[y == target, 0], X_pca[y == target, 1], c=color, label=label, alpha=0.7)
# axes[0].set_title('True Wine Classes (PCA Reduced)')
# axes[0].set_xlabel('PC1')
# axes[0].set_ylabel('PC2')
# axes[0].legend()
# axes[0].grid(True)

# # Plot KMeans clusters
# for cluster_id, color in zip(range(3), ['r', 'g', 'b']):
#     axes[1].scatter(X_pca[clusters == cluster_id, 0], X_pca[clusters == cluster_id, 1], c=color, label=f'Cluster {cluster_id}', alpha=0.7)
# axes[1].set_title('KMeans Clusters (PCA Reduced)')
# axes[1].set_xlabel('PC1')
# axes[1].set_ylabel('PC2')
# axes[1].legend()
# axes[1].grid(True)

# plt.tight_layout()
# plt.show()

# #Evaluate clustering quality with Adjusted Rand Index
# from sklearn.metrics import adjusted_rand_score

# ari = adjusted_rand_score(y, clusters)
# print(f'Adjusted Rand Index between true labels and KMeans clusters: {ari:.3f}')

# #ARI = 1 means perfect match.
# #ARI close to 0 means random clustering.


# #----------------------------------------------------------------
# #How to compute Explained Variance from SVD components
# #Interpretation:
# #The values tell you the proportion of total variance each principal component explains.
# #The sum of all explained variance ratios equals 1 (or 100%).

# #Summary :
# # Always center your data first (subtract mean per feature).
# # Then do SVD on centered data.
# # Compute explained variance from singular values.

# import numpy as np

# # Example data (replace this with your real dataset)
# X = np.random.rand(100, 5)  # 100 samples, 5 features

# # Center the data
# X_centered = X - np.mean(X, axis=0)

# # Perform SVD on centered data
# U, S, VT = np.linalg.svd(X_centered, full_matrices=False)

# # Compute explained variance
# n_samples = X_centered.shape[0]
# variance_explained = (S ** 2) / (n_samples - 1)
# explained_variance_ratio = variance_explained / variance_explained.sum()

# # Display explained variance ratio
# for i, ratio in enumerate(explained_variance_ratio, start=1):
#     print(f"PC{i}: {ratio:.4f}")

# #---------------------------------


# import numpy as np
# import matplotlib.pyplot as plt
# from sklearn.datasets import load_wine

# # Load dataset and center it
# data = load_wine()
# X = data.data
# X_centered = X - np.mean(X, axis=0)
# n_samples = X_centered.shape[0]

# # Compute SVD
# U, S, VT = np.linalg.svd(X_centered, full_matrices=False)

# # Explained variance
# variance_explained = (S ** 2) / (n_samples - 1)
# explained_variance_ratio = variance_explained / variance_explained.sum()

# # Scree plot
# plt.figure(figsize=(10, 4))

# plt.subplot(1, 2, 1)
# plt.bar(range(1, len(explained_variance_ratio) + 1), explained_variance_ratio, alpha=0.7, color='b')
# plt.xlabel('Principal Component')
# plt.ylabel('Explained Variance Ratio')
# plt.title('Scree Plot')
# plt.xticks(range(1, len(explained_variance_ratio) + 1))

# # Cumulative explained variance plot
# plt.subplot(1, 2, 2)
# plt.plot(np.cumsum(explained_variance_ratio), marker='o', color='r')
# plt.xlabel('Number of Principal Components')
# plt.ylabel('Cumulative Explained Variance')
# plt.title('Cumulative Explained Variance Plot')
# plt.grid(True)
# plt.ylim(0, 1.05)

# plt.tight_layout()
# plt.show()


#----------------------------------------------------------------------------
# #Linear Descriminant Analysis (LDA)

# #Manual LDA Step-by-Step on Iris Dataset

# #Step 1: Import Libraries and Load Data

# import numpy as np
# import matplotlib.pyplot as plt
# from sklearn.datasets import load_iris

# # Load Iris dataset
# iris = load_iris()
# X = iris.data  # shape (150, 4)
# y = iris.target  # labels 0,1,2
# class_labels = np.unique(y)
# print("X :\n",X)
# print("y :\n",y)
# print("class_labels :\n",class_labels)


# #Step 2: Compute the Overall Mean Vector
# mean_overall = np.mean(X, axis=0)
# print("mean_overall :\n",mean_overall)

# #Step 3: Compute the Mean Vectors for Each Class
# mean_vectors = []
# for cl in class_labels:
#     mean_vectors.append(np.mean(X[y == cl], axis=0))

# print("mean_vectors : \n",mean_vectors)

# #Step 4: Compute the Within-Class Scatter Matrix 𝑆𝑊​

# n_features = X.shape[1]
# S_W = np.zeros((n_features, n_features))
# print("n_features : \n",n_features)
# print("S_W : \n",S_W)

# for cl, mv in zip(class_labels, mean_vectors):
#     class_scatter = np.zeros((n_features, n_features))  # scatter matrix for each class
#     for row in X[y == cl]:
#         row, mv = row.reshape(n_features, 1), mv.reshape(n_features, 1)
#         class_scatter += (row - mv).dot((row - mv).T)
#     S_W += class_scatter

# #Step 5: Compute the Between-Class Scatter Matrix 𝑆B
# S_B = np.zeros((n_features, n_features))
# for i, mean_vec in enumerate(mean_vectors):
#     n = X[y == i, :].shape[0]
#     mean_vec = mean_vec.reshape(n_features, 1)  # column vector
#     mean_overall_vec = mean_overall.reshape(n_features, 1)
#     S_B += n * (mean_vec - mean_overall_vec).dot((mean_vec - mean_overall_vec).T)

# #Step 6: Solve the Generalized Eigenvalue and Eigenvectors
# eigvals, eigvecs = np.linalg.eig(np.linalg.inv(S_W).dot(S_B))

# #Step 7: Sort Eigenvectors by Eigenvalues in Descending Order
# # Make eigenvalues real (sometimes small imaginary parts)
# eigvals = np.real(eigvals)
# eigvecs = np.real(eigvecs)

# # Sort descending
# sorted_indices = np.argsort(eigvals)[::-1]
# eigvals = eigvals[sorted_indices]
# eigvecs = eigvecs[:, sorted_indices]

# #Step 8: Select Top k Eigenvectors (Linear Discriminants)
# #Since Iris has 3 classes, max k = 2

# k = 2
# W = eigvecs[:, :k]  # projection matrix (4x2)

# #Step 9: Project the Data Onto New Subspace
# X_lda = X.dot(W)  # shape (150, 2)

# #Step 10: Visualize the Projected Data
# plt.figure(figsize=(8,6))
# colors = ['r', 'g', 'b']
# labels = ['Setosa', 'Versicolor', 'Virginica']

# for color, cl, label in zip(colors, class_labels, labels):
#     plt.scatter(X_lda[y == cl, 0], X_lda[y == cl, 1], color=color, label=label)

# plt.xlabel('LD1')
# plt.ylabel('LD2')
# plt.title('Manual LDA: Iris dataset projection')
# plt.legend()
# plt.grid()
# plt.show()

# #Summary
# #You computed within-class and between-class scatter matrices
# #Solved eigenvalue problem 
# #Selected eigenvectors corresponding to largest eigenvalues (directions that maximize class separability)
# #Projected data to lower dimension (2D)
# #Visualized class separation!


# #Step-by-step classification using manual LDA components
# #Step 1: Split data into train and test sets

# from sklearn.model_selection import train_test_split

# # X_lda is from previous step (shape: 150 x 2)
# X_train, X_test, y_train, y_test = train_test_split(X_lda, y, test_size=0.3, random_state=42)

# #Step 2: Choose and train a classifier (e.g., Logistic Regression)

# from sklearn.linear_model import LogisticRegression

# clf = LogisticRegression()
# clf.fit(X_train, y_train)

# #Step 3: Predict on test set and evaluate

# y_pred = clf.predict(X_test)

# from sklearn.metrics import accuracy_score, classification_report

# print("Accuracy:", accuracy_score(y_test, y_pred))
# print("\nClassification Report:\n", classification_report(y_test, y_pred))

# #Step 4 (Optional): Visualize decision boundaries

# import matplotlib.pyplot as plt
# import numpy as np

# # Create meshgrid
# x_min, x_max = X_lda[:, 0].min() - 1, X_lda[:, 0].max() + 1
# y_min, y_max = X_lda[:, 1].min() - 1, X_lda[:, 1].max() + 1
# xx, yy = np.meshgrid(np.arange(x_min, x_max, 0.02),
#                      np.arange(y_min, y_max, 0.02))

# Z = clf.predict(np.c_[xx.ravel(), yy.ravel()])
# Z = Z.reshape(xx.shape)

# plt.figure(figsize=(8,6))
# plt.contourf(xx, yy, Z, alpha=0.3, cmap='Accent')

# colors = ['r', 'g', 'b']
# labels = ['Setosa', 'Versicolor', 'Virginica']

# for color, cl, label in zip(colors, np.unique(y), labels):
#     plt.scatter(X_lda[y == cl, 0], X_lda[y == cl, 1], c=color, label=label, edgecolors='k')

# plt.xlabel('LD1')
# plt.ylabel('LD2')
# plt.title('Classification Boundaries on LDA components')
# plt.legend()
# plt.show()

# #Summary
# # We split the LDA-reduced data into train and test.
# # Trained a logistic regression classifier on those 2 features.
# # Evaluated classification accuracy and detailed report.
# # Visualized decision boundaries in LDA space.

#************************
# #Apply multiclass LDA to the Digits dataset (10 classes)
# #Step-by-Step: Manual Multiclass LDA on Digits

# import numpy as np
# import matplotlib.pyplot as plt
# from sklearn.datasets import load_digits

# # Load dataset
# digits = load_digits()
# X = digits.data           # shape (1797, 64)
# y = digits.target         # labels 0–9
# classes = np.unique(y)    # array of digit classes
# n_classes = len(classes)
# n_features = X.shape[1]

# #1. Compute Mean Vectors
# mean_overall = np.mean(X, axis=0)
# mean_vectors = [np.mean(X[y == c], axis=0) for c in classes]

# #2. Compute Within-Class Scatter 𝑆𝑊
# S_W = np.zeros((n_features, n_features))
# for c, mv in zip(classes, mean_vectors):
#     class_scatter = np.zeros((n_features, n_features))
#     for x in X[y == c]:
#         diff = (x - mv).reshape(n_features, 1)
#         class_scatter += diff @ diff.T
#     S_W += class_scatter

# #3. Compute Between-Class Scatter 𝑆𝐵
# S_B = np.zeros((n_features, n_features))
# for c, mv in zip(classes, mean_vectors):
#     n_c = X[y == c].shape[0]
#     diff = (mv - mean_overall).reshape(n_features, 1)
#     S_B += n_c * (diff @ diff.T)

# #4. Solve the Generalized Eigenvalue Problem

# epsilon = 1e-4
# S_W_reg = S_W + epsilon * np.eye(S_W.shape[0])

# from scipy.linalg import eigh
# eigvals, eigvecs = eigh(S_B, S_W_reg)

# #eigvals, eigvecs = np.linalg.eig(np.linalg.inv(S_W) @ S_B)
# #That LinAlgError: Singular matrix means your within-class scatter matrix 𝑆𝑊
# #is singular (non-invertible), which is common when:
# #You have high-dimensional data but not enough samples (e.g., features > samples per class).
# #Some features are linearly dependent or redundant.
# #The data is not full rank in some classes.


# eigvals = np.real(eigvals)
# eigvecs = np.real(eigvecs)

# # Sort descending
# idxs = np.argsort(eigvals)[::-1]
# eigvecs = eigvecs[:, idxs]
# eigvals = eigvals[idxs]

# #5. Construct the LDA Projection (Top 𝐶−1=9 components)
# W = eigvecs[:, :n_classes - 1]  # shape (64, 9)
# X_lda = X @ W                   # projected data (1797, 9)

# #Step 6: Visualizing in 2D with Leading Components
# #To visualize, we can reduce further to just the first two LDA components:

# plt.figure(figsize=(10, 8))
# for c in classes:
#     plt.scatter(X_lda[y == c, 0], X_lda[y == c, 1], label=str(c), alpha=0.6)
# plt.xlabel('LD1')
# plt.ylabel('LD2')
# plt.title('Multiclass LDA on Digits Dataset (First 2 Discriminants)')
# plt.legend(title='Digit')
# plt.grid(True)
# plt.show()

# #In practice, while LDA yields up to 9 components for 10 classes, 
# # the first two often capture most of the discriminative power. 
# # The plot should show distinct clusters for at least some digits, 
# # demonstrating LDA's ability to separate multiple classes effectively.

# #Summary
# #LDA generalizes cleanly to multiclass scenarios.
# #It projects data into at most 𝐶−1 dimensions—here, 9.
# #Even visualizing only 2 dimensions from that space often retains strong separability.
# #Ideal for visualization, dimensionality reduction, and preprocessing for classification.



# #--------------------------------------------------------
# # t-Distributed Stochastic Neighbor Embedding (t-SNE)
# #Quick example with Python (scikit-learn):

# from sklearn.datasets import load_digits
# from sklearn.manifold import TSNE
# import matplotlib.pyplot as plt

# # Load digits data
# digits = load_digits()
# X = digits.data
# y = digits.target

# # Initialize and fit t-SNE
# tsne = TSNE(n_components=2, random_state=42)
# X_embedded = tsne.fit_transform(X)

# # Plot
# plt.figure(figsize=(8, 6))
# scatter = plt.scatter(X_embedded[:, 0], X_embedded[:, 1], c=y, cmap='tab10', alpha=0.7)
# plt.colorbar(scatter, label='Digit Label')
# plt.title('t-SNE visualization of Digits dataset')
# plt.xlabel('t-SNE dim 1')
# plt.ylabel('t-SNE dim 2')
# plt.show()

#*******************
#Modular t-SNE implementation with dataset support

import numpy as np
import matplotlib.pyplot as plt

def Hbeta(D, beta=1.0):
    """Compute entropy and P-row for a given precision beta."""
    P = np.exp(-D * beta)
    sumP = np.sum(P)
    H = np.log(sumP) + beta * np.sum(D * P) / sumP
    P = P / sumP
    return H, P

def compute_P(X, perplexity=30.0, tol=1e-5):
    """Compute symmetric P affinities with fixed perplexity using binary search."""
    n = X.shape[0]
    D = np.square(np.linalg.norm(X[:, np.newaxis] - X[np.newaxis, :], axis=2))
    P = np.zeros((n, n))
    beta = np.ones((n, 1))
    logU = np.log(perplexity)

    for i in range(n):
        betamin, betamax = -np.inf, np.inf
        Di = np.delete(D[i], i)
        H, thisP = Hbeta(Di, beta[i])

        Hdiff = H - logU
        tries = 0
        while np.abs(Hdiff) > tol and tries < 50:
            if Hdiff > 0:
                betamin = beta[i].copy()
                beta[i] = beta[i]*2 if betamax == np.inf or betamax == -np.inf else (beta[i] + betamax)/2
            else:
                betamax = beta[i].copy()
                beta[i] = beta[i]/2 if betamin == np.inf or betamin == -np.inf else (beta[i] + betamin)/2
            H, thisP = Hbeta(Di, beta[i])
            Hdiff = H - logU
            tries += 1
        P[i, np.concatenate((np.r_[0:i], np.r_[i+1:n]))] = thisP

    P = (P + P.T) / (2 * n)
    P = np.maximum(P, 1e-12)
    return P

def compute_Q(Y):
    """Compute low-dimensional affinities using Student t-distribution."""
    sum_Y = np.sum(np.square(Y), axis=1)
    D = -2 * np.dot(Y, Y.T) + sum_Y[:, None] + sum_Y[None, :]
    num = 1 / (1 + D)
    np.fill_diagonal(num, 0)
    Q = num / np.sum(num)
    Q = np.maximum(Q, 1e-12)
    return Q, num

def gradient_descent(P, Y, lr=200.0, n_iter=1000, momentum=0.5, early_exaggeration=4.0):
    n = P.shape[0]
    Y = Y.copy()
    dY = np.zeros_like(Y)
    iY = np.zeros_like(Y)
    P *= early_exaggeration

    for iter in range(n_iter):
        Q, num = compute_Q(Y)
        PQ_diff = P - Q
        for i in range(n):
            dY[i, :] = 4 * np.sum(np.tile(PQ_diff[:, i] * num[:, i], (Y.shape[1], 1)).T * (Y[i, :] - Y), axis=0)
        iY = momentum * iY - lr * dY
        Y += iY

        if iter == 100:
            P /= early_exaggeration

        if (iter + 1) % 100 == 0 or iter == 0:
            cost = np.sum(P * np.log(P / Q))
            print(f"Iteration {iter +1}: KL divergence={cost:.5f}")

    return Y

def tsne(X, perplexity=30, lr=200, n_iter=1000, dim=2, random_state=42, verbose=True):
    np.random.seed(random_state)
    P = compute_P(X, perplexity=perplexity)
    Y_init = np.random.randn(X.shape[0], dim)
    if verbose:
        print("Starting gradient descent...")
    Y = gradient_descent(P, Y_init, lr=lr, n_iter=n_iter)
    if verbose:
        print("t-SNE embedding completed.")
    return Y

def plot_embedding(Y, labels=None, title="t-SNE Embedding"):
    plt.figure(figsize=(8, 6))
    if labels is not None:
        scatter = plt.scatter(Y[:, 0], Y[:, 1], c=labels, cmap='tab10', s=15)
        plt.colorbar(scatter)
    else:
        plt.scatter(Y[:, 0], Y[:, 1], s=15)
    plt.title(title)
    plt.xticks([])
    plt.yticks([])
    plt.show()

# Example usage on digits dataset:
if __name__ == "__main__":
    from sklearn.datasets import load_digits

    digits = load_digits()
    X = digits.data
    y = digits.target

    Y_embedded = tsne(X, perplexity=30, lr=200, n_iter=500)
    plot_embedding(Y_embedded, labels=y, title="t-SNE on Digits dataset")




#*******************
# #Example: Trying different perplexities and learning rates on Digits dataset

# import matplotlib.pyplot as plt
# from sklearn.manifold import TSNE
# from sklearn.datasets import load_digits

# digits = load_digits()
# X = digits.data
# y = digits.target

# perplexities = [5, 30, 50]
# learning_rates = [10, 200, 1000]

# fig, axes = plt.subplots(len(perplexities), len(learning_rates), figsize=(15, 12))
# fig.suptitle('t-SNE: Effect of Perplexity and Learning Rate', fontsize=16)

# for i, perp in enumerate(perplexities):
#     for j, lr in enumerate(learning_rates):
#         tsne = TSNE(n_components=2, perplexity=perp, learning_rate=lr, random_state=42)
#         X_embedded = tsne.fit_transform(X)
        
#         ax = axes[i, j]
#         scatter = ax.scatter(X_embedded[:, 0], X_embedded[:, 1], c=y, cmap='tab10', s=10)
#         ax.set_title(f'Perplexity={perp}, LR={lr}')
#         ax.set_xticks([])
#         ax.set_yticks([])

# plt.tight_layout(rect=[0, 0, 1, 0.96])
# plt.show()
