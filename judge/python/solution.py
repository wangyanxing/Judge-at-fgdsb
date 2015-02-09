from common import *
# Definition of Point
# class Point:
#     def __init__(self, x=0, y=0):
#         self.x = x
#         self.y = y

def search(pt, visited, mat):
    dirs = [[0,1], [0,-1], [1,0], [-1,0]]
    for i, dir in enumerate(dirs) :
        new_pt = Point(dir[0] + pt.x, dir[1] + pt.y)
        if new_pt.x < 0 or new_pt.x >= len(mat) or new_pt.y < 0 or new_pt.y >= len(mat): continue
        if mat[new_pt.x][new_pt.y] < mat[pt.x][pt.y] or visited.has_key(new_pt): continue
        visited[new_pt] = True
        search(new_pt, visited, mat)


def flowing_water(mat):
    n = len(mat)
    
    visited_pac = {}
    
    for i in range(0, n):
        p = Point(0, i)
        visited_pac[p] = True
        search(p, visited_pac, mat)
        
    for i in range(0, n):
        p = Point(i, 0)
        visited_pac[p] = True
        search(p, visited_pac, mat)
        
    visited_alt = {}
    
    for i in range(0, n):
        p = Point(n - 1, i)
        visited_alt[p] = True
        search(p, visited_alt, mat)
        
    for i in range(0, n):
        p = Point(i, n - 1)
        visited_alt[p] = True
        search(p, visited_alt, mat)
        
    ret = []
    for k, v in visited_alt.iteritems() :
        if visited_pac.has_key(k): ret.append(k)
    ret.sort()
    return ret