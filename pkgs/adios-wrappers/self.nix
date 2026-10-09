{ types, ... }:
{
  options = {
    tack = {
      type = types.attrs;
      defaultFunc = { options }: options.tack;
    };
  };
}
