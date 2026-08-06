import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

from sklearn.preprocessing import MinMaxScaler
from sklearn.metrics import mean_squared_error
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import LSTM, Dense

# ---------------------
# Load or generate data
# ---------------------
def generate_dummy_data():
    # Create a sine wave as dummy time series data
    time = np.arange(0, 100, 0.1)
    data = np.sin(time) + 0.1 * np.random.randn(len(time))
    return pd.DataFrame(data, columns=['value'])

# ---------------------
# Prepare dataset
# ---------------------
def create_sequences(data, seq_length):
    x, y = [], []
    for i in range(len(data) - seq_length):
        x.append(data[i:i+seq_length])
        y.append(data[i+seq_length])
    return np.array(x), np.array(y)

# ---------------------
# Main training pipeline
# ---------------------
def main():
    # Parameters
    SEQ_LENGTH = 50
    EPOCHS = 20
    BATCH_SIZE = 32

    # Load data
    df = generate_dummy_data()
    values = df['value'].values.reshape(-1, 1)

    # Scale data
    scaler = MinMaxScaler(feature_range=(0, 1))
    scaled_data = scaler.fit_transform(values)

    # Create sequences
    X, y = create_sequences(scaled_data, SEQ_LENGTH)

    # Split into training and testing
    split = int(0.8 * len(X))
    X_train, X_test = X[:split], X[split:]
    y_train, y_test = y[:split], y[split:]

    # Reshape input for LSTM [samples, timesteps, features]
    X_train = X_train.reshape((X_train.shape[0], X_train.shape[1], 1))
    X_test = X_test.reshape((X_test.shape[0], X_test.shape[1], 1))

    # Build model
    model = Sequential()
    model.add(LSTM(50, return_sequences=False, input_shape=(SEQ_LENGTH, 1)))
    model.add(Dense(1))
    model.compile(optimizer='adam', loss='mse')

    # Train model
    history = model.fit(X_train, y_train, epochs=EPOCHS, batch_size=BATCH_SIZE, validation_data=(X_test, y_test), verbose=1)

    # Predict
    y_pred = model.predict(X_test)

    # Invert scaling
    y_test_inv = scaler.inverse_transform(y_test.reshape(-1, 1))
    y_pred_inv = scaler.inverse_transform(y_pred)

    # Calculate error
    rmse = np.sqrt(mean_squared_error(y_test_inv, y_pred_inv))
    print(f"Test RMSE: {rmse:.4f}")

    # Plot
    plt.figure(figsize=(10, 6))
    plt.plot(y_test_inv, label='True')
    plt.plot(y_pred_inv, label='Predicted')
    plt.title('Time Series Prediction')
    plt.xlabel('Time Step')
    plt.ylabel('Value')
    plt.legend()
    plt.show()

if __name__ == '__main__':
    main()
