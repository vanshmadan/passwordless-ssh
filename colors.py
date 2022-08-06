file1= open('colour.txt','r')
count=0
colour1 = []
sum= []
while True:
    count += 1
  
    # Get next line from file
    line = file1.readline()
  
    # if line is empty
    # end of file is reached
    if not line:
        break
    line=line.strip()
    l1=line.split(" ")
    l1[0]=l1[0].capitalize()
    if l1[0] not in colour1:
        colour1.append(l1[0])
        sum.append(int(l1[1]))
    else:
        sum[colour1.index(l1[0])]+=int(l1[1])

for i in range(len(colour1)):
    print(colour1[i]+" "+str(sum[i]))
file1.close()
