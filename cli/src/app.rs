use rust_embed::Embed;
use std::collections::HashMap;
use std::fmt::format;
use std::path::Path;
use std::fs;

#[derive(Embed)]
#[folder = "assets/wallpaper-gnome"]
struct GnomeWallPapers;

struct Wallpaper {
    id: String,
    dir: String,
    light: String,
    dark: String,
}
pub struct App {
    wallpapers: HashMap<String, Wallpaper>,
}

impl App {
    const WALLPAPERS_PATH: &'static str = "/home/rey/dotfiles/cli/test";
    // const WALLPAPERS_PATH: &'static str = "/usr/share/backgrounds/gnome";
    // const XML_PATH: &'static str = "/usr/share/gnome-background-properties";
    const XML_PATH: &'static str = "/home/rey/dotfiles/cli/test";

    pub fn new() -> Self {
        let mut wallpapers: HashMap<String, Wallpaper> = HashMap::new();

        for asset_path in GnomeWallPapers::iter() {
            let asset_path = asset_path.to_string();
            let path = Path::new(&asset_path);
            let dir = path.parent().unwrap_or_else(|| Path::new(""));
            let file_name = path.file_name().unwrap().to_str().unwrap_or_else(|| "");

            let is_light = asset_path.contains("-l.");
            let dir = dir.to_str().unwrap().to_string();

            wallpapers
                .entry(dir.clone())
                .and_modify(|w| {
                    if is_light {
                        w.light = file_name.to_string();
                    } else {
                        w.dark = file_name.to_string();
                    }
                })
                .or_insert_with(|| Wallpaper {
                    id: dir.replace("-", "").to_uppercase(),
                    dir,
                    light: if is_light { file_name.to_string() } else { String::new() },
                    dark: if !is_light { file_name.to_string() } else { String::new() },
                });
        }

        Self { wallpapers }
    }

    pub fn uninstall_wallpapers(&self) {
        for (key, wallpaper) in &self.wallpapers {
            self.remove_img(wallpaper.light.to_string());
            self.remove_img(wallpaper.dark.to_string());

            self.remove_xml(key.to_string())
        }
    }

    pub fn install_wallpapers(&self) {
        for (_, wallpaper) in &self.wallpapers {
            self.gen_xml(wallpaper);

            self.move_img(wallpaper.dir.clone(), wallpaper.dark.clone());
            self.move_img(wallpaper.dir.clone(), wallpaper.light.clone());
        }
    }

    fn move_img(&self, dir: String, file: String) {
        let img_source = format!("{}/{}", dir, file);
        let img = GnomeWallPapers::get(&img_source).unwrap();
        let img_dest = format!("{}/{}", Self::WALLPAPERS_PATH, file);
        fs::write(img_dest, img.data.as_ref()).unwrap();
    }

    fn gen_xml(&self, wallpaper: &Wallpaper) {
        let file_path = format!("{}/{}.xml", Self::XML_PATH, wallpaper.dir);
        let xml = format!(
            r#"
        <?xml version="1.0"?>
        <!DOCTYPE wallpapers SYSTEM "gnome-wp-list.dtd">
        <wallpapers>
          <wallpaper deleted="false">
            <name>{}</name>
            <filename>/usr/share/backgrounds/gnome/{}</filename>
            <filename-dark>/usr/share/backgrounds/gnome/{}</filename-dark>
            <options>zoom</options>
            <shade_type>solid</shade_type>
            <pcolor>#77767B</pcolor>
            <scolor>#000000</scolor>
          </wallpaper>
        </wallpapers>
        "#,
            wallpaper.id, wallpaper.light, wallpaper.dark
        );

        fs::write(file_path, xml).unwrap();
    }

    fn remove_img(&self, file: String) {
        let path = format!("{}/{}", Self::WALLPAPERS_PATH, file);
        fs::remove_file(path);
    }

    fn remove_xml(&self, file_name: String) {
        let path = format!("{}/{}.xml", Self::XML_PATH, file_name);
        fs::remove_file(path);
    }
}
