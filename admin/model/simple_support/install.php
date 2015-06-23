<?php
    class ModelSimpleSupportInstall extends Model {
        public function addExtensionTables() {
            
            $this->db->query(
                "CREATE TABLE IF NOT EXISTS ". DB_PREFIX . "simple_support_department (
                    `simple_support_department_id` int(16) NOT NULL AUTO_INCREMENT,
                      `department_head_id` int(16) NOT NULL,
                      `language_id` int(16) NOT NULL,
                      `name` varchar(64) NOT NULL,
                      `status` tinyint(1) NOT NULL,
                      `date_added` datetime NOT NULL,
                      `date_modified` datetime NOT NULL,
                      PRIMARY KEY (`simple_support_department_id`,`language_id`)
                    ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1"
            );
            
            $this->db->query(
                "CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "simple_support_department_employee (
                  `simple_support_department_id` int(16) NOT NULL,
                  `customer_department` varchar(16) NOT NULL,
                  `admin_department` varchar(16) NOT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=latin1"
            );
            
            $this->db->query(
                "CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "simple_support_faq (
                  `simple_support_faq_id` int(16) NOT NULL AUTO_INCREMENT,
                  `simple_support_faq_group_id` int(16) NOT NULL,
                  `sort_order` int(8) NOT NULL,
                  `status` tinyint(1) NOT NULL,
                  `date_added` datetime NOT NULL,
                  `date_modified` datetime NOT NULL,
                  PRIMARY KEY (`simple_support_faq_id`)
                ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1"
            );
            
            $this->db->query(
                "CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "simple_support_faq_description (
                  `simple_support_faq_id` int(16) NOT NULL,
                  `language_id` int(16) NOT NULL,
                  `question` varchar(256) NOT NULL,
                  `answer` text NOT NULL,
                  `meta_description` varchar(256) NOT NULL,
                  `meta_keyword` varchar(256) NOT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=latin1"
            );
            
            $this->db->query(
                "CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "simple_support_faq_group (
                  `simple_support_faq_group_id` int(16) NOT NULL AUTO_INCREMENT,
                  `sort_order` int(8) NOT NULL,
                  `status` tinyint(1) NOT NULL,
                  `date_added` datetime NOT NULL,
                  `date_modified` datetime NOT NULL,
                  PRIMARY KEY (`simple_support_faq_group_id`)
                ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1"
            );
            
            $this->db->query(
                "CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "simple_support_faq_group_description (
                  `simple_support_faq_group_id` int(16) NOT NULL,
                  `language_id` int(16) NOT NULL,
                  `name` varchar(64) NOT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=latin1"
            );
            
            $this->db->query(
                "CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "simple_support_faq_to_store (
                  `simple_support_faq_id` int(16) NOT NULL,
                  `store_id` int(16) NOT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=latin1"
            );
            
             $this->db->query(
                "CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "simple_support_status (
                  `simple_support_status_id` int(16) NOT NULL AUTO_INCREMENT,
                  `language_id` int(16) NOT NULL,
                  `name` varchar(64) NOT NULL,
                  `date_added` datetime NOT NULL,
                  `date_modified` datetime NOT NULL,
                  PRIMARY KEY (`simple_support_status_id`,`language_id`)
                ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1"
            );
            
            $this->db->query(
                "CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "simple_support_ticket (
                  `simple_support_ticket_id` int(16) NOT NULL AUTO_INCREMENT,
                  `ticket_id` varchar(64) NOT NULL,
                  `customer_id` int(16) NOT NULL,
                  `user_id` int(16) NOT NULL,
                  `simple_support_department_id` int(16) NOT NULL,
                  `subject` varchar(256) NOT NULL,
                  `description` text NOT NULL,
                  `status` tinyint(1) NOT NULL DEFAULT '1',
                  `simple_support_ticket_status_id` tinyint(1) NOT NULL,
                  `date_added` datetime NOT NULL,
                  `date_modified` datetime NOT NULL,
                  PRIMARY KEY (`simple_support_ticket_id`)
                ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1"
            );
            
             $this->db->query(
                "CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "simple_support_ticket_history (
                  `simple_support_ticket_history_id` int(16) NOT NULL AUTO_INCREMENT,
                  `simple_support_ticket_id` int(16) NOT NULL,
                  `customer_id` int(16) NOT NULL,
                  `user_id` int(16) NOT NULL,
                  `description` text NOT NULL,
                  `date_added` datetime NOT NULL,
                  PRIMARY KEY (`simple_support_ticket_history_id`)
                ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1"
            );
            
            $this->db->query(
                "CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "simple_support_ticket_images (
                  `simple_support_ticket_images_id` int(16) NOT NULL AUTO_INCREMENT,
                  `simple_support_ticket_history_id` int(16) NOT NULL,
                  `simple_support_ticket_id` int(16) NOT NULL,
                  `image` text NOT NULL,
                  PRIMARY KEY (`simple_support_ticket_images_id`)
                ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1"
            );
        }
    }
?>