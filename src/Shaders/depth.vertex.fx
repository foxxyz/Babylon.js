﻿// Attribute
attribute vec3 position;
#include<bonesDeclaration>

#include<morphTargetsVertexGlobalDeclaration>
#include<morphTargetsVertexDeclaration>[0..maxSimultaneousMorphTargets]

// Uniform
#include<instancesDeclaration>

uniform mat4 viewProjection;
uniform vec2 depthValues;

#if defined(ALPHATEST) || defined(NEED_UV)
varying vec2 vUV;
uniform mat4 diffuseMatrix;
#ifdef UV1
attribute vec2 uv;
#endif
#ifdef UV2
attribute vec2 uv2;
#endif
#endif

varying float vDepthMetric;

void main(void)
{
vec3 positionUpdated = position;
#include<morphTargetsVertex>[0..maxSimultaneousMorphTargets]

#include<instancesVertex>

#include<bonesVertex>

	gl_Position = viewProjection * finalWorld * vec4(positionUpdated, 1.0);
	
	vDepthMetric = ((gl_Position.z + depthValues.x) / (depthValues.y));

#if defined(ALPHATEST) || defined(BASIC_RENDER)
#ifdef UV1
	vUV = vec2(diffuseMatrix * vec4(uv, 1.0, 0.0));
#endif
#ifdef UV2
	vUV = vec2(diffuseMatrix * vec4(uv2, 1.0, 0.0));
#endif
#endif
}
