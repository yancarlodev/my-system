# NixOS/Nix/Home Manager Command Cheatsheet

## **NixOS System Management**
```bash
# Apply new system configuration
sudo nixos-rebuild switch

# Apply new system configuration using flake
sudo nixos-rebuild switch --flake ~/my-nix-config#laptop

# Dry-run (see what would be installed/changed)
sudo nixos-rebuild dry-run

# Build but don't activate configuration
sudo nixos-rebuild build

# Boot into latest generation (without applying)
sudo nixos-rebuild boot

# Rollback to previous generation
sudo nixos-rebuild switch --rollback

# List all system generations
sudo nix-env --list-generations -p /nix/var/nix/profiles/system

# Garbage collect old generations/unused packages
sudo nix-collect-garbage -d
```

---

## **General Nix Commands**
```bash
# Enter a temporary shell with package(s)
nix-shell -p package1 package2

# Search for packages
nix search nixpkgs package-name

# Update nix-channel
nix-channel --update

# Check nix store disk usage
nix-store --query --disk-usage /nix/store
```

---

## **Nix Development Shells**
```bash
# Enter a development shell defined in flake.nix (default)
nix develop

# Enter a specific development shell from flake.nix
nix develop .#shell-name

# Run a command in the shell and exit (e.g., build a project)
nix develop --command 'echo "Hello, Nix!"'
```

### **Example `flake.nix` Dev Shell**
```nix
{
  outputs = { nixpkgs, ... }: {
    devShells.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
      packages = [ 
        nixpkgs.legacyPackages.x86_64-linux.python3
        nixpkgs.legacyPackages.x86_64-linux.nodejs
      ];
      shellHook = ''
        echo "Welcome to your Python/Node.js dev shell!"
      '';
    };
  };
}
```

---

## **Home Manager (User-Level)**
```bash
# Apply user configuration (after initial setup)
home-manager switch

# Apply user configuration using flakes
home-manager switch --flake /my-flake/#username@hostname

# Build config without activating
home-manager build

# List Home Manager generations
home-manager generations

# Rollback to previous Home Manager generation
home-manager switch --rollback

# Update Home Manager channel
home-manager update
```

---

## **Flake Commands**
```bash
# Run system with flake config
sudo nixos-rebuild switch --flake .#hostname

# Update all flake inputs
nix flake update

# Show flake outputs
nix flake show

# Build a specific flake output
nix build .#output-name
```

---

**File Locations**:
- System Config: `/etc/nixos/configuration.nix`
- User Config: `~/.config/home-manager/home.nix`
- Flake Config: `~/my-nix-config/flake.nix`