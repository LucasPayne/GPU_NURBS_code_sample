GPU_NURBS    code sample - Lucas Payne 2020
================================================================================
Real-time quadratic Non-uniform rational B-splines on the GPU using OpenGL-4 and GLSL.
The surface is visualized as a moving red wireframe, viewable with a fly-around
controllable camera. This is a graphics programming code sample, and will not
compile without linking with the larger graphics framework.

"NURBS" are a hugely popular surface description used in computer-aided design.
The real-time rendering of these surfaces is an interesting problem.
How feasible is it for, e.g., video-games, to use CAD formats directly,
for high-quality non-polygonal surface rendering?

The main mathematical reference used in creating this demo is
    The NURBS book, Piegl and Tiller (1997).

![tessellation](https://github.com/LucasPayne/GPU_NURBS_code_sample/blob/main/images/tessellation.png?raw=true)

Overview of program structure
================================================================================
GLSL shaders
--------------------------------------------------------------------------------
*quadratic_NURBS.vert, quadratic_NURBS.tcs, quadratic_NURBS.tes, quadratic_NURBS.geom, quadratic_NURBS.frag*
Four shader stages (vertex, tessellation, geometry, and fragment
processing) are compiled and linked into one GPU program.
- The vertex shader passes data along to the control shader.
- The tessellation control shader sets constant tessellation parameters
 (determining how many u,v coordinates are generated).
- The tessellation evaluation shader computes the corresponding point on
 the NURBS surface, then performs the view and projection transformations.
- The geometry shader expands triangle primitives into three lines each,
 generating a wireframe.
- The fragment shader outputs constant red.
The result (alongside the CPU code) is a (non-antialiased) red wireframe
quadratic NURBS surface with a variable number of patches and arbitrary
knot vectors.

C++ source
--------------------------------------------------------------------------------
*CameraController.cpp*
Mouse view and movement controls to attach to a camera entity.
*nurbs_demo.cpp*
This is the essential code sample of the quadratic NURBS demo. This file
is a project file for my graphics framework (called "cg_sandbox"), which
this code must be linked to.

A full description of the important steps in the program is below.
main:
- Initialize an OpenGL context and loop (using my small library "interactive_graphics_context", with a glfw3 backend)
- Create the cg_sandbox "world" and attach it to the context.
- Create the application.
Application initialization:
- Create the camera man entity.
- Initialize the control net.
- Create a new entity.
- Create the DrawableNURBS behaviour, give it the control net, and attach it to the entity.
DrawableNURBS initialization:
- Initialize a default knot configuration.
- Initialize GPU data with OpenGL-4 buffers.
- Load, compile, and link the 5 shaders into one GPU program.
main continued:
- Enter the overall logic and rendering loop.
- Each frame, all entity components and behaviours are updated.
DrawableNURBS update:
- Move the control grid and knots around for visual effect.
- Reupload control grid and knot buffers to the GPU.
- Render the NURBS surface (upload GPU constants and render into each camera using the compiled shader program).
