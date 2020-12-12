var textContext = new TextContext(noone);
textContext.AddSubText(new SubText("slow0123456789", 0.05));
textContext.AddSubText(new SubText("normal0123456789", 0.1));
textContext.AddSubText(new SubText("fast0123456789", 0.2));

RenderText(textContext);