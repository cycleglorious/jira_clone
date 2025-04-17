"use client";
import { useAuthModalContext } from "@/context/use-auth-modal";
import { useUser } from "@clerk/clerk-react";

export const useIsAuthenticated = (): [string | undefined, () => void] => {
  const { user } = useUser();
  const { setAuthModalIsOpen } = useAuthModalContext();

  function openAuthModal() {
    setAuthModalIsOpen(true);
  }

  console.log(user);

  return [user?.id, openAuthModal];
};
