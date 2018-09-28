/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models.migrations;

import java.lang.reflect.InvocationTargetException;
import models.migrations.migrations.CreateBooksTable;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.database.DB;
import models.database.MySQLConnect;
import models.migrations.migrations.AddColumnsInBooksTable;
import models.migrations.migrations.CreateBookCategoryPivotTable;
import models.migrations.migrations.CreateCategoriesTable;
import models.migrations.migrations.CreateImagesTable;
import models.migrations.migrations.CreateMigrationsTable;
import models.migrations.migrations.CreateBookUserPivotTable;
import models.migrations.migrations.CreateOrderDetailsTable;
import models.migrations.migrations.CreateOrdersTable;
import models.migrations.migrations.CreateProfilesTable;
import models.migrations.migrations.CreateRatesTable;
import models.migrations.migrations.CreateRolesTable;
import models.migrations.migrations.CreateUsersTable;

/**
 *
 * @author ASUS
 */
public class Migration {

    protected Connection connection;

    public Migration() {
        try {
            this.connection = MySQLConnect.getMySQLConnection();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(Migration.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void up() {
        new CreateUsersTable().up();
        new CreateBooksTable().up();
        new CreateBookUserPivotTable().up();
        new CreateRolesTable().up();
        new CreateProfilesTable().up();
        new CreateImagesTable().up();
        new AddColumnsInBooksTable().up();
        new CreateCategoriesTable().up();
        new CreateBookCategoryPivotTable().up();
        new CreateOrdersTable().up();
        new CreateOrderDetailsTable().up();
        new CreateRatesTable().up();
    }

    public void down() {

    }

    public void down(Migration migration) {
        List<HashMap<String, String>> list = new DB("migrations")
                .select("*")
                .orderBy("batch DESC")
                .get();
        migration.down(list);
    }

    public boolean exists() {
        return new Table("migrations").exists(this.getClass().getName());
    }

    public void down(List<HashMap<String, String>> list) {
        list.forEach((map) -> {
            try {
                Migration m = (Migration) Class.forName(map.get("name")).getConstructor().newInstance();
                m.down();
            } catch (InstantiationException
                    | IllegalAccessException
                    | IllegalArgumentException
                    | InvocationTargetException
                    | ClassNotFoundException
                    | NoSuchMethodException
                    | SecurityException ex) {
                Logger.getLogger(Migration.class.getName()).log(Level.SEVERE, null, ex);
            }
        });
    }

    public void addMigration(String name) {
        List<HashMap<String, String>> list = new DB("migrations")
                .select("*")
                .orderBy("batch DESC")
                .limit(1)
                .get();

        int max_batch = 0;
        if (!list.isEmpty()) {
            max_batch = Integer.parseInt(list.get(0).get("batch"));
        }
        max_batch++;
        new DB("migrations").insert(new String[]{name, "" + max_batch});
    }

    public void removeMigration(String name) {
        new DB("migrations").delete().where(new String[]{"name = '" + name + "'"}).execute();
    }

    public static void main(String[] args) {
        int n = 0;
        Migration migration = new Migration();
        Scanner sc = new Scanner(System.in);
        System.out.println("1. Migrate");
        System.out.println("2. RollBack");
        System.out.println("3. Create Migration");
        System.out.println("4. Drop Migration");
        System.out.println("5. Refresh");
        System.out.println("6. Rollback All");
        System.out.println("0. Exit");
        System.out.println("Choose: ");
        n = sc.nextInt();
        switch (n) {
            case 1: {
                migration.up();

                break;
            }

            case 2: {
                List<HashMap<String, String>> list = new DB("migrations")
                        .select("*")
                        .orderBy("batch DESC")
                        .limit(1)
                        .get();
                migration.down(list);

                break;
            }

            case 3: {
                new CreateMigrationsTable().up();

                break;
            }

            case 4: {
                new CreateMigrationsTable().down();

                break;
            }

            case 5: {
                migration.down(migration);
                migration.up();

                break;
            }

            case 6: {
                migration.down(migration);

                break;
            }
        }
    }
}
