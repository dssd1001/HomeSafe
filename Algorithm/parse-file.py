f = open('allCoordinates.txt', 'r')
g = open('input-data.txt', 'w')
for line in f:
    line = line.strip()
    while line[0] != '[':
        line = line[1:]
    x = eval(line)
    for i in x:
        g.write(str(i) + ' ')
        print(str(i) + ' ', end="")
    g.write('696969\n')
    print('696969')
    