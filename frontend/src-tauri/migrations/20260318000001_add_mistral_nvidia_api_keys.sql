-- Add mistralApiKey and nvidiaApiKey columns to settings table
ALTER TABLE settings ADD COLUMN mistralApiKey TEXT;
ALTER TABLE settings ADD COLUMN nvidiaApiKey TEXT;
