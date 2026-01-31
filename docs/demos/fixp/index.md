---
title: Fixed Point Design
parent: Demos
nav_order: 3
has_children: true
---
# Fixed‑Point Implementation of a Polynomial

In this demo, we walk through how to implement a simple polynomial using **fixed‑point arithmetic**. To keep the example focused, we consider a monic cubic function expressed in floating point:

```python
y = x**3 + a2 * x**2 + a1 * x + a0
```

## Why Fixed‑Point?

Fixed‑point arithmetic is widely used in digital hardware because it offers **deterministic behavior**, **low latency**, and **efficient resource usage** compared to floating point. Many embedded systems, DSP blocks, and accelerators operate under tight area, power, or timing constraints, making floating‑point units impractical. By choosing appropriate bit‑widths, we can achieve excellent numerical accuracy while keeping the implementation small, fast, and synthesizable.

## What You Will Learn

By working through this demo, you will learn to:

* Implement and simulate a **fixed‑point** version of a nonlinear function in Python  
* Measure the **approximation error** introduced by fixed‑point quantization and choose appropriate bit‑widths  
* Generate **test vectors** from a Python **golden model** of the fixed‑point function  
* Implement the same fixed‑point function in SystemVerilog and **validate** the RTL against the golden test vectors  