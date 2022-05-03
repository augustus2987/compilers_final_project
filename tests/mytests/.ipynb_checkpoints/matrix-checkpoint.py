list matrix1 = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
print matrix1
list matrix2 = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

matrix1[0][0] = matrix2[2][2]
matrix1[0][1] = matrix2[2][1]
matrix1[0][2] = matrix2[2][0]
matrix1[1][0] = matrix2[1][2]
matrix1[1][1] = matrix2[1][1]
matrix1[1][2] = matrix2[1][0]
matrix1[2][0] = matrix2[0][2]
matrix1[2][1] = matrix2[0][1]
matrix1[2][2] = matrix2[0][0]

print matrix1