import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { ExternalLinkIcon } from "lucide-react";
import { create } from "zustand";
import { commands } from "@/lib/utils/tauri";

export function LoginDialog() {
  // Loopcut: local-only mode — login dialog disabled
  return null;
}

interface LoginDialogState {
  isOpen: boolean;
  setIsOpen: (open: boolean) => void;
  checkLogin: (user: any | null, showDialog?: boolean) => boolean;
}

export const useLoginDialog = create<LoginDialogState>((set) => ({
  isOpen: false,
  setIsOpen: (open) => set({ isOpen: open }),
  checkLogin: (_user, _showDialog = true) => {
    // Loopcut: local-only mode — always return true (no login required)
    return true;
  },
}));
