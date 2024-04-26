using Comodo
using GLMakie
using GeometryBasics
using Statistics
using Rotations
using LinearAlgebra

# Example curves
testCase = 1

if testCase == 1
    r = 1.0
    nc = 15
    t = range(0,2*π,nc)
    Vc = [Point3{Float64}(2.0+tt,0.0,sin(tt)) for tt ∈ t]
    Vc,_ = evenly_sample(Vc, nc)
    n = Vec{3, Float64}(0.0,0.0,1.0)
    num_steps = 31
    close_loop = false
elseif testCase == 2
        r = 1.0
        nc = 15
        t = range(0,2*π,nc)
        Vc = [Point3{Float64}(2.0+tt,0.0,sin(tt)) for tt ∈ t]
        Vc,_ = evenly_sample(Vc, nc)
        n = normalizevector(Vec{3, Float64}(0.0,-1.0,1.0))
        num_steps = 31
        close_loop = false
elseif testCase == 3
    r = 1.0
    nc = 16
    t = range(2.0*π-(2.0*π/nc),0,nc)
    Vc = [Point3{Float64}(2.0+cos(tt),0.0,sin(tt)) for tt ∈ t]
    Vc,_ = evenly_sample(Vc, nc)
    n = Vec{3, Float64}(0.0,0.0,1.0)
    num_steps = 25
    close_loop = true
end

θ=1.0*pi
F1,V1 = revolvecurve(Vc,θ;  s=1, n=n ,num_steps=num_steps, close_loop=close_loop,face_type=:quad)
F2,V2 = revolvecurve(Vc,θ;  s=0, n=n, num_steps=num_steps, close_loop=close_loop,face_type=:tri_slash)
F3,V3 = revolvecurve(Vc,θ;  s=-1, n=n, num_steps=num_steps, close_loop=close_loop,face_type=:tri)
F4,V4 = revolvecurve(Vc,θ;  s=-1, n=n, num_steps=num_steps, close_loop=close_loop,face_type=:quad2tri)

M1 = GeometryBasics.Mesh(V1,F1)
M2 = GeometryBasics.Mesh(V2,F2)
M3 = GeometryBasics.Mesh(V3,F3)
M4 = GeometryBasics.Mesh(V4,F4)

## Visualization
markersize = 8 

fig = Figure(size=(1800,800))

ax1 = Axis3(fig[1, 1], aspect = :data, xlabel = "X", ylabel = "Y", zlabel = "Z", title = """Revolved s=1, close_loop=$close_loop, face_type=:quad""")
hp1 = lines!(ax1,Vc,color=:red,linewidth=4, transparency=true, depth_shift=-1.0f-3)
hp2 = scatter!(ax1,Vc,markersize=markersize,color=:red)
hp3 = poly!(ax1,M1, strokewidth=1,color=:white, strokecolor=:black, shading = FastShading, transparency=false)
# normalplot(ax1,M1)

ax2 = Axis3(fig[1, 2], aspect = :data, xlabel = "X", ylabel = "Y", zlabel = "Z", title = """Revolved s=0, close_loop=$close_loop, face_type=:tri_slash""")
hp1 = lines!(ax2,Vc,color=:red,linewidth=4, transparency=true, depth_shift=-1.0f-3)
hp2 = scatter!(ax2,Vc,markersize=markersize,color=:red)
hp3 = poly!(ax2,M2, strokewidth=1,color=:white, strokecolor=:black, shading = FastShading, transparency=false)
# normalplot(ax2,M2)

ax3 = Axis3(fig[2, 1], aspect = :data, xlabel = "X", ylabel = "Y", zlabel = "Z", title = """Revolved s=-1, close_loop=$close_loop, face_type=:tri""")
hp1 = lines!(ax3,Vc,color=:red,linewidth=4, transparency=true, depth_shift=-1.0f-3)
hp2 = scatter!(ax3,Vc,markersize=markersize,color=:red)
hp3 = poly!(ax3,M3, strokewidth=1,color=:white, strokecolor=:black, shading = FastShading, transparency=false)
# normalplot(ax3,M3)

ax4 = Axis3(fig[2, 2], aspect = :data, xlabel = "X", ylabel = "Y", zlabel = "Z", title = """Revolved s=-1, close_loop=$close_loop, face_type=:quad2tri""")
hp1 = lines!(ax4,Vc,color=:red,linewidth=4, transparency=true, depth_shift=-1.0f-3)
hp2 = scatter!(ax4,Vc,markersize=markersize,color=:red)
hp3 = poly!(ax4,M4, strokewidth=1,color=:white, strokecolor=:black, shading = FastShading, transparency=false)
# normalplot(ax3,M3)

# Legend(fig[1, 4],[hp1,hp2],["Input curve","Surface"])

fig
