{
  hasHost = hostname: module: if module ? hosts then builtins.elem hostname module.hosts else true;
  # Unused, still thinking about implementation details
  isEnabled = module: module.enable or true;
}
