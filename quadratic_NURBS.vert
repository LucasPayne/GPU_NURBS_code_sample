// Pass-through vertex shader
#version 420
layout(location = 0) in vec3 position;

out VS_OUT {
    vec3 position;
} vs_out;

uniform mat4x4 mvp_matrix;

void main(void)
{
    vs_out.position = position;
}
