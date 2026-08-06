import nltk
import random
from nltk.chat.util import Chat, reflections

# Define a set of patterns and responses
pairs = [
    (r'hi|hello|hey', ['Hello! How can I help you today?', 'Hi there!', 'Hey! How can I assist you?']),
    (r'what is your name?', ['I am a simple chatbot created in Python.', 'I don\'t have a name, but I can help you!']),
    (r'how are you?', ['I am doing well, thank you!', 'I am just a bot, but I am functioning fine.']),
    (r'bye|goodbye', ['Goodbye! Take care!', 'See you later!', 'Goodbye, have a great day!']),
    (r'(.*)', ['I am not sure about that, can you ask something else?', 'Sorry, I didn\'t understand that. Can you rephrase?']),
]

# Initialize the chatbot with reflections and pairs
def chatbot():
    print("Hello! I'm your chatbot. Type 'bye' to exit.")
    chat = Chat(pairs, reflections)
    chat.converse()

# Start the chatbot
if __name__ == "__main__":
    chatbot()
