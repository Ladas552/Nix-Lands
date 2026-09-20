{ types, ... }:
{
  options = {
    self = {
      type = types.attrs;
      defaultFunc = { options }: options.self;
    };
  };
}
