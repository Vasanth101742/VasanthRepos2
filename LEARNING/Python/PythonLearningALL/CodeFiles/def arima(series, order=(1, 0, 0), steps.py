def arima(series, order=(1, 0, 0), steps=1):
	"""Fit an ARIMA model and return a list of forecast values."""
	if steps < 1:
		raise ValueError("steps must be >= 1")

	try:
		from statsmodels.tsa.arima.model import ARIMA
	except Exception as exc:
		raise ImportError("statsmodels is required. Install it with: pip install statsmodels") from exc

	data = list(series)
	if len(data) < 2:
		raise ValueError("series must contain at least 2 data points")

	model = ARIMA(data, order=order)
	fitted = model.fit()
	return list(fitted.forecast(steps=steps))

