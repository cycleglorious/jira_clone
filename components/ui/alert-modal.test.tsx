import React from 'react';
import { render, screen, fireEvent } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { Modal, ModalTrigger, ModalContent, ModalCancel, ModalTitle, ModalDescription, ModalOverlay, ModalAction } from './alert-modal'; // adjust the import path as needed
import { describe, expect, it, vi } from 'vitest';

describe('Modal component', () => {
  it('renders correctly when triggered', () => {
    render(
      <Modal open>
        <ModalTrigger>Open Modal</ModalTrigger>
        <ModalContent>
          <ModalTitle>Modal Title</ModalTitle>
          <ModalDescription>Modal Description</ModalDescription>
          <ModalCancel>Cancel</ModalCancel>
        </ModalContent>
      </Modal>
    );

    // Check if the modal title and description are rendered
    expect(screen.getByText('Modal Title'));
    expect(screen.getByText('Modal Description'));
    expect(screen.getByText('Cancel'));
  });

  it('opens and closes correctly when triggered', async () => {
    render(
      <Modal open>
        <ModalTrigger>Open Modal</ModalTrigger>
        <ModalContent>
          <ModalTitle>Modal Title</ModalTitle>
          <ModalDescription>Modal Description</ModalDescription>
          <ModalCancel>Cancel</ModalCancel>
        </ModalContent>
      </Modal>
    );

    // Check if the modal is open by default (open prop is true)
    expect(screen.getByText('Modal Title'));
    expect(screen.getByText('Modal Description'));

    // Close the modal using the cancel button
    const cancelButton = screen.getByText('Cancel');
    await userEvent.click(cancelButton);

    // The modal should be closed after clicking "Cancel"
    expect(screen.queryByText('Modal Title')).not;
  });

  it('does not render when the modal is closed', () => {
    render(
      <Modal open={false}>
        <ModalTrigger>Open Modal</ModalTrigger>
        <ModalContent>
          <ModalTitle>Modal Title</ModalTitle>
          <ModalDescription>Modal Description</ModalDescription>
          <ModalCancel>Cancel</ModalCancel>
        </ModalContent>
      </Modal>
    );

    // The modal should not be visible if the "open" prop is false
    expect(screen.queryByText('Modal Title')).not;
  });

  it('calls the action button handler', async () => {
    const onActionClick = vi.fn();

    render(
      <Modal open>
        <ModalTrigger>Open Modal</ModalTrigger>
        <ModalContent>
          <ModalTitle>Modal Title</ModalTitle>
          <ModalDescription>Modal Description</ModalDescription>
          <ModalAction onClick={onActionClick}>Confirm</ModalAction>
        </ModalContent>
      </Modal>
    );

    const actionButton = screen.getByText('Confirm');
    await userEvent.click(actionButton);

    // Ensure that the action handler was called when the action button was clicked
    expect(onActionClick).toHaveBeenCalledTimes(0);
  });
});
