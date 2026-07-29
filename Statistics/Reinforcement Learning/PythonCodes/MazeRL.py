#MazeRL

#Step 1: Import libraries and Define Maze, Start and Goal

import numpy as np
import matplotlib.pyplot as plt
from matplotlib.colors import ListedColormap

maze = np.array([
    [0, 1, 1, 1, 1, 1, 1, 1, 1, 1],
    [0, 0, 0, 0, 1, 0, 0, 0, 0, 1],
    [1, 1, 1, 0, 1, 0, 1, 1, 0, 1],
    [1, 0, 0, 0, 0, 0, 1, 0, 0, 1],
    [1, 0, 1, 1, 1, 1, 1, 0, 1, 1],
    [1, 0, 1, 0, 0, 0, 0, 0, 1, 1],
    [1, 0, 1, 0, 1, 1, 1, 0, 1, 1],
    [1, 0, 1, 0, 1, 0, 0, 0, 1, 1],
    [1, 0, 1, 0, 1, 0, 1, 0, 0, 1],
    [1, 1, 1, 0, 1, 1, 1, 1, 0, 0]
])
# print("maze.shape :",maze.shape )
# print("maze.shape[0] :",maze.shape[0] )
# input()

start = (0, 0)
goal = (9, 9)
# print("type(start)",type(start)) #tuple
# print("type(goal)",type(goal)) #tuple
# input()

#Step 2: Define RL Parameters and Initialize Q-Table

num_episodes = 5000
alpha = 0.1
gamma = 0.6
epsilon = 0.5

reward_fire = -10
reward_goal = 50
reward_step = -1

actions = [(0, -1), (0, 1), (-1, 0), (1, 0)]
#print("len(actions) :",len(actions)) #4
#input()


Q = np.zeros(maze.shape + (len(actions),))
# print("Q :\n", Q)
# print("Q :\n", Q.shape)
# input()

#Code Practice
# Q1 = np.zeros(maze.shape)
# print("Q1 :\n", Q1)
# Q2 = np.zeros(maze.shape + (len(actions)))  #Why error occurs, what does it mean?
# print("Q1 :\n", Q2)



#Step 3: Helper Function for Maze Validity and Action Selection

def is_valid(pos):
    r, c = pos
    if r < 0 or r >= maze.shape[0]:
        return False
    if c < 0 or c >= maze.shape[1]:
        return False
    if maze[r, c] == 1:
        return False
    return True


def choose_action(state):
    if np.random.random() < epsilon:
        return np.random.randint(len(actions))
    else:
        a= np.argmax(Q[state])
        # print("[state] :",[state])
        # print("Q[state] :",Q[state])
        # print("np.argmax(Q[state])",np.argmax(Q[state]))
        # input()
        return a
    

#Step 4: Train the Agent with Q-Learning Algorithm

rewards_all_episodes = []

for episode in range(num_episodes):
    print("episode **************",episode)
    state = start
    total_rewards = 0
    done = False

    while not done:
        action_index = choose_action(state)
        action = actions[action_index]
        print("action_index :",action_index)
        print("action :",action)
        input()
        
        next_state = (state[0] + action[0], state[1] + action[1])
        # print("state[0]",state[0]) 
        # print("action[0]",action[0])
        # print("state[1]",state[1]) 
        # print("action[1]",action[1])
        #print("next_state :",next_state)
        # input()

        if not is_valid(next_state):
            reward = reward_fire
            done = True
        elif next_state == goal:
            reward = reward_goal
            done = True
        else:
            reward = reward_step

        old_value = Q[state][action_index]
        # print("Q[state][action_index]",Q[state][action_index])
        # print("old_value",old_value)
        
        next_max = np.max(Q[next_state]) if is_valid(next_state) else 0
        # print("next_state",next_state)
        # print("next_max",next_max)
        
        Q[state][action_index] = old_value + alpha *(reward + gamma * next_max - old_value)
        # print("old_value",old_value)
        # print("alpha",alpha)
        # print("reward",reward)
        # print("gamma",gamma)
        # print("next_max",next_max)
        # print("formula :",old_value + alpha * (reward + gamma * next_max - old_value))
        # print("Q[state][action_index]",Q[state][action_index])
        state = next_state
        # print("state",state)
        total_rewards += reward


    #global epsilon
    epsilon = max(0.01, epsilon * 0.995)
    rewards_all_episodes.append(total_rewards)
    #print("rewards_all_episodes",rewards_all_episodes)
#input()


#print("Q : \n",Q)
#Step 5: Extract the Optimal Path after Training

def get_optimal_path(Q, start, goal, actions, maze, max_steps=200):
    path = [start]
    state = start
    visited = set()

    for _ in range(max_steps):
        if state == goal:
            break
        visited.add(state)

        best_action = None
        best_value = -float('inf')

        for idx, move in enumerate(actions):
            next_state = (state[0] + move[0], state[1] + move[1])

            if (0 <= next_state[0] < maze.shape[0] and
                0 <= next_state[1] < maze.shape[1] and
                maze[next_state] == 0 and
                    next_state not in visited):

                if Q[state][idx] > best_value:
                    best_value = Q[state][idx]
                    best_action = idx

        if best_action is None:
            break

        move = actions[best_action]
        state = (state[0] + move[0], state[1] + move[1])
        path.append(state)

    return path


optimal_path = get_optimal_path(Q, start, goal, actions, maze)


#Step 6: Visualize the Maze, Robot Path, Start and Goal

def plot_maze_with_path(path):
    cmap = ListedColormap(['#eef8ea', '#a8c79c'])

    plt.figure(figsize=(8, 8))
    plt.imshow(maze, cmap=cmap)

    plt.scatter(start[1], start[0], marker='o', color='#81c784', edgecolors='black',
                s=200, label='Start (Robot)', zorder=5)
    plt.scatter(goal[1], goal[0], marker='*', color='#388e3c', edgecolors='black',
                s=300, label='Goal (Diamond)', zorder=5)

    rows, cols = zip(*path)
    plt.plot(cols, rows, color='#60b37a', linewidth=4,
             label='Learned Path', zorder=4)

    plt.title('Reinforcement Learning: Robot Maze Navigation')
    plt.gca().invert_yaxis()
    plt.xticks(range(maze.shape[1]))
    plt.yticks(range(maze.shape[0]))
    plt.grid(True, alpha=0.2)
    plt.legend()
    plt.tight_layout()
    plt.show()


plot_maze_with_path(optimal_path)