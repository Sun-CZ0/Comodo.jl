using Comodo
using GLMakie
using GeometryBasics
using Rotations

# Creating faces and vertices for a rhombic dodecahedron
F,V = rhombicdodecahedron(5.0)

## Visualize mesh
markersize = 25
strokewidth = 2 
strokecolor = :black
fig = Figure(size = (800,800))

ax1 = Axis3(fig[1, 1], aspect = :data, xlabel = "X", ylabel = "Y", zlabel = "Z", title = "Rhombic dodecahedron")

hp1 = poly!(ax1, GeometryBasics.Mesh(V,F), color=:white,transparency=false,strokewidth=strokewidth,strokecolor=strokecolor,shading = FastShading)
hp2 = scatter!(ax1, V,markersize=markersize,color=:red)
hp3 = normalplot(ax1,F,V; color = :green)

fig