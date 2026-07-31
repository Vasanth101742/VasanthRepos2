from flask import Flask, jsonify
import subprocess

app = Flask(__name__)

@app.route('/run-script', methods=['GET'])
def run_script():
    # Example: Run your Python script as a subprocess
    result = subprocess.run(['python', 'D:\Forecasting\Forecast_DFUwise_Monthwise.py'], capture_output=True, text=True)
    
    # Return script output or any message
    return jsonify({
        'output': result.stdout,
        'error': result.stderr,
        'returncode': result.returncode
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
