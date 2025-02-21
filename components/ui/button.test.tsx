import React from 'react';
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { Button } from './button'; // Make sure the path is correct
import { describe, it, expect, vi } from 'vitest';

describe('Button component', () => {
  it('renders the button with correct text', () => {
    render(<Button>Click me</Button>);
    const buttonElement = screen.getByRole('button', { name: /click me/i });
    expect(buttonElement);
  });

  it('executes onClick handler when clicked', async () => {
    const onClick = vi.fn();
    render(<Button onClick={onClick}>Click me</Button>);
    
    const buttonElement = screen.getByRole('button', { name: /click me/i });
    await userEvent.click(buttonElement);

    expect(onClick).toHaveBeenCalledTimes(1);
  });
});
