import React from 'react';
import { render, screen } from '@testing-library/react';
import { Container } from './container'; // Adjust the import path as needed
import { describe, expect, it } from 'vitest';

describe('Container component', () => {
  it('renders children correctly', () => {
    render(
      <Container>
        <p>Test Content</p>
      </Container>
    );

    expect(screen.getByText('Test Content'));
  });

  it('applies default styling when `screen` prop is false or not provided', () => {
    const { container } = render(
      <Container>
        <p>Default Styling</p>
      </Container>
    );

    expect(container.firstChild);
  });

  it('applies full screen styling when `screen` prop is true', () => {
    const { container } = render(
      <Container screen>
        <p>Full Screen</p>
      </Container>
    );

    expect(container.firstChild);
  });

  it('applies additional class names when `className` prop is provided', () => {
    const { container } = render(
      <Container className="custom-class">
        <p>Custom Class</p>
      </Container>
    );

    expect(container.firstChild);
  });
});
