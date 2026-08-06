from openai import AzureOpenAI
from dotenv import load_dotenv
import os

print(load_dotenv())

client=AzureOpenAI(
api_version=os.getenv("OPEN_API_VERSION"),
azure_endpoint=os.getenv("OPEN_API_BASE"),
api_key=os.getenv("OPEN_API_KEY")
)

# Test GPT Model
messages=[{"role":"system","content":str("you a comedian chatbot")},
          {"role":"user","content":str("hello")}
          ]

responses=client.chat.completions.create(
    model=os.getenv("gpt_deployment_name"),
    messages=messages
)

responses.choices[0].message.content


# Test Embedding Model
