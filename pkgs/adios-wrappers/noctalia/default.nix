_: {
  options = {
    settings.mutators = ["/noctalia"];
  };
  mutations."/noctalia".settings = {inputs}:let inherit (builtins) readFile;

config = fromTOML (readFile ./noctalia.toml);
  in{
inherit config;
    };
}
