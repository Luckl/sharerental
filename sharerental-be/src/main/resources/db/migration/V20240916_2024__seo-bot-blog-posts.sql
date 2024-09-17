-- Table for BlogCategory
CREATE TABLE blog_category (
                               id TEXT PRIMARY KEY,
                               title TEXT NOT NULL,
                               slug TEXT NOT NULL
);

-- Table for BlogTag
CREATE TABLE blog_tag (
                          id TEXT PRIMARY KEY,
                          title TEXT NOT NULL,
                          slug TEXT NOT NULL
);

-- Table for BlogArticle
CREATE TABLE blog_article (
                              id TEXT PRIMARY KEY,
                              slug TEXT NOT NULL,
                              headline TEXT NOT NULL,
                              meta_description TEXT NOT NULL,
                              meta_keywords TEXT NOT NULL,
                              html TEXT NOT NULL,
                              outline TEXT NOT NULL,
                              deleted BOOLEAN NOT NULL,
                              published BOOLEAN NOT NULL,
                              category_id TEXT REFERENCES blog_category(id) ON DELETE CASCADE,
                              reading_time NUMERIC NOT NULL,
                              published_at TIMESTAMP NOT NULL
);

-- Join table for the many-to-many relationship between BlogArticle and BlogTag
CREATE TABLE blog_article_tags (
                                   blog_article_id TEXT,
                                   tags_id TEXT,
                                   PRIMARY KEY (blog_article_id, tags_id),
                                   FOREIGN KEY (blog_article_id) REFERENCES blog_article(id) ON DELETE CASCADE,
                                   FOREIGN KEY (tags_id) REFERENCES blog_tag(id) ON DELETE CASCADE
);

-- Join table for the self-referencing many-to-many relationship in BlogArticle (relatedPosts)
CREATE TABLE blog_article_related_posts (
                                            blog_article_id TEXT,
                                            related_posts_id TEXT,
                                            PRIMARY KEY (blog_article_id, related_posts_id),
                                            FOREIGN KEY (blog_article_id) REFERENCES blog_article(id) ON DELETE CASCADE,
                                            FOREIGN KEY (related_posts_id) REFERENCES blog_article(id) ON DELETE CASCADE
);
