{ types, ... }:
{
  options = {
    sources = {
      type = types.attrs;
      defaultFunc = { options }: options.sources;
    };
  };
}
