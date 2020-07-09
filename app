import numpy as np
from random import randrange

def generate_a_maze(level):

    lenght = 3 + 2*(level - 1)
    mul = 5

    maze = -np.ones((lenght, lenght), dtype=np.int32)
    #gmaze = np.chararray((lenght*mul, lenght*mul))
    #gmaze[:] = '#'

    gmaze = [['#' for j in range(lenght*mul)] for i in range(lenght*mul)]
    for i in range(lenght*mul):
        print(gmaze[i])

    current_path = []

    side = randrange(4)
    start_coord = randrange(lenght)
    start = [0, start_coord]

    if side == 1:
        start[0] = start_coord
        start[1] = 0
    elif side == 2:
        start[0] = lenght - 1
        start[1] = start_coord
    elif side == 3:
        start[0] = start_coord
        start[1] = lenght - 1

    maze[start[0], start[1]] = 0

    selected = []
    selected.append(start)
    current = start

    while len(selected) < lenght*lenght:
        x = current[0]
        y = current[1]
        depth = maze[x, y]
        neighbours = []

        if x > 0:
            p = [x-1, y]
            contain = False
            for pr in selected:
                if pr == p:
                    contain = True
                    break
            if contain == False:
                neighbours.append(p)
                if maze[p[0], p[1]] == -1:
                    maze[p[0], p[1]] = depth + 1

        if x < lenght - 1:
            p = [x+1, y]
            contain = False
            for pr in selected:
                if pr == p:
                    contain = True
                    break
            if contain == False:
                neighbours.append(p)
                if maze[p[0], p[1]] == -1:
                    maze[p[0], p[1]] = depth + 1

        if y > 0:
            p = [x, y-1]
            contain = False
            for pr in selected:
                if pr == p:
                    contain = True
                    break
            if contain == False:
                neighbours.append(p)
                if maze[p[0], p[1]] == -1:
                    maze[p[0], p[1]] = depth + 1

        if y < lenght - 1:
            p = [x, y+1]
            contain = False
            for pr in selected:
                if pr == p:
                    contain = True
                    break
            if contain == False:
                neighbours.append(p)
                if maze[p[0], p[1]] == -1:
                    maze[p[0], p[1]] = depth + 1


        next = [-1, -1]
        deapest = -1

        if len(neighbours) > 0:
            next = neighbours[0]
            deapest = maze[next[0], next[1]]

        if len(neighbours) > 1: #razmisliti da li izbaciti ovu liniju
            for p in neighbours:
                if maze[p[0], p[1]] > deapest:
                    next = p
                    deapest = maze[p[0], p[1]]
                elif maze[p[0], p[1]] == deapest:
                    ran = randrange(2)
                    if ran == 1:
                        next = p

        if len(neighbours) > 0:
            print(neighbours)
            print(next)
            a = range(1, mul*2 - 1)
            b = range(1, mul - 1)
            if current[0] == next[0] - 1 and current[1] == next[1]:
                for i in a:
                    for j in b:
                        gmaze[current[0] * mul + i][current[1] * mul + j] = ' '
            elif current[0] == next[0] + 1 and current[1] == next[1]:
                for i in a:
                    for j in b:
                        gmaze[next[0] * mul + i][next[1] * mul + j] = ' '
            elif current[0] == next[0] and current[1] == next[1] - 1:
                for i in a:
                    for j in b:
                        gmaze[current[0] * mul + j][current[1] * mul + i] = ' '
            else:
                for i in a:
                    for j in b:
                        print(i)
                        print(j)
                        print(next[0] * mul + j)
                        print(next[1] * mul + i)
                        gmaze[next[0] * mul + j][next[1] * mul + i] = ' '

            current = next
            current_path.append(next)
            selected.append(next)
        else:
            current_path.pop()
            if len(current_path) > 0:
                current = current_path[len(current_path) - 1]
            else:
                break

    p = []
    end = start
    max_distance = 0
    for i in range(lenght):
        if max_distance < maze[0, i]:
            max_distance = maze[0, i]
            end = [0, i]
        if max_distance < maze[i, 0]:
            max_distance = maze[i, 0]
            end = [i, 0]
    for i in range(1, mul-1):
        for j in range(1, mul-1):
            gmaze[start[0] * mul + i][start[1] * mul + j] = 's'
            gmaze[end[0] * mul + i][end[1] * mul + j] = 'e'

    final_maze = []
    for i in range(lenght*mul):
        row = []
        if(not (i % mul == mul - 1 and i != lenght*mul - 1)):
            for j in range(lenght*mul):
                if (not (j % mul == mul - 1 and j != lenght * mul - 1)):
                    row.append(gmaze[i][j])
            final_maze.append(row)

    gstart = [start[0]*(mul - 1) + round(mul/2), start[1]*(mul - 1) + round(mul/2)]

    return [maze, start, end, final_maze, gstart]

[nmaze, start, end, gmaze, gstart] = generate_a_maze(1)

print("labirnit")
print(nmaze)
print("startna tacka")
print(start)
print("krajnja tacka")
print(end)
print("tuneli")
print("lokacija starta")
print(gstart)
print([len(gmaze)])
gmaze[gstart[0]][gstart[1]] = 'o'
for i in range(len(gmaze)):
    print(''.join(gmaze[i]))